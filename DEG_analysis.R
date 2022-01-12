# Gene expression analysis
# D.N. De Panis

# Reference genome: D. buzzatii release1 decon
# Aligner/counter: RSEM
# Data: FPKM normalized-counts w/ RSEM = 13567 genes

# Treatments:
# Op_Prot_Nat = O. sulphurea (O) = Op_n
# Tr_Prot_Nat = T. terscheckii (T) = Tr_n
# Tr_Prot_Alk = T. terscheckii 2x alkaloids (T2) = Tr_y


Dbuz_counts.table <- read.table("Dbuz.genes_fpkm.table", header=TRUE,
                                row.names = 1)
head(Dbuz_counts.table)
dim(Dbuz_counts.table)


###   NOISeq    ################################################################

#source("https://bioconductor.org/biocLite.R")
#biocLite("NOISeq")
#library(NOISeq)


# Norm. data (FPKM) by RSEM (NOT by NOISeq)
dim(mycounts.noiseq_Db.r1_RSEM.fpkm)#13657
head(mycounts.noiseq_Db.r1_RSEM.fpkm)
class(mycounts.noiseq_Db.r1_RSEM.fpkm)


myfactors = data.frame(
  cact.add_alk = c("Op_n", "Op_n", "Op_n", 
                   "Tr_n", "Tr_n", "Tr_n", 
                   "Tr_y", "Tr_y", "Tr_y")
)  


mydata = readData(data = Dbuz_counts.table, factors = myfactors)
class(mydata)
mydata


# Comparison I:
NAT_Op.vs.Tr = noiseqbio(mydata, k = NULL, norm = "n", factor = "cact.add_alk",
                         conditions = c("Op_n", "Tr_n"), plot = TRUE,
                         filter = 1)

# Comparison II:
Tr_Nat.vs.Alk = noiseqbio(mydata, k = NULL, norm = "n", factor = "cact.add_alk",
                          conditions = c("Tr_n", "Tr_y"), plot = TRUE,
                          filter = 1)


## RESULTS #####################################################################

# Comparison I
head(degenes(NAT_Op.vs.Tr, q = 0.99, M = NULL))
head(degenes(NAT_Op.vs.Tr, q = 0.95, M = NULL))

DE.plot(NAT_Op.vs.Tr, q = 0.99, graphic = "expr", log.scale = TRUE)
head(degenes(NAT_Op.vs.Tr, q = 0.99, M = "up"))
head(degenes(NAT_Op.vs.Tr, q = 0.99, M = "down"))


write.table(rownames(degenes(NAT_Op.vs.Tr, q = 0.99, M = NULL)),
            "NAT_Op.vs.Tr_TOTAL.q99.list",
            quote = FALSE,
            sep="\t",
            row.names = FALSE,
            col.names = FALSE
            )

write.table(rownames(degenes(NAT_Op.vs.Tr, q = 0.99, M = "up")),
            "NAT_Op.vs.Tr_UP.q99.list",
            quote = FALSE,
            sep="\t",
            row.names = FALSE,
            col.names = FALSE
)

write.table(rownames(degenes(NAT_Op.vs.Tr, q = 0.99, M = "down")),
            "NAT_Op.vs.Tr_DOWN.q99.list",
            quote = FALSE,
            sep="\t",
            row.names = FALSE,
            col.names = FALSE
)


# Comparison II
head(degenes(Tr_Nat.vs.Alk, q = 0.99, M = NULL)) #24
head(degenes(Tr_Nat.vs.Alk, q = 0.95, M = NULL)) #54
# Let's use q95 to expand this particular gene-set a little

DE.plot(Tr_Nat.vs.Alk, q = 0.95, graphic = "expr", log.scale = TRUE)
head(degenes(Tr_Nat.vs.Alk, q = 0.95, M = "up"))
head(degenes(Tr_Nat.vs.Alk, q = 0.95, M = "down"))


write.table(rownames(degenes(Tr_Nat.vs.Alk, q = 0.95, M = NULL)),
            "Tr_Nat.vs.Alk_TOTAL.q95.list",
            quote = FALSE,
            sep="\t",
            row.names = FALSE,
            col.names = FALSE
)

write.table(rownames(degenes(Tr_Nat.vs.Alk, q = 0.95, M = "up")),
            "Tr_Nat.vs.Alk_UP.q95.list",
            quote = FALSE,
            sep="\t",
            row.names = FALSE,
            col.names = FALSE
)

write.table(rownames(degenes(Tr_Nat.vs.Alk, q = 0.95, M = "down")),
            "Tr_Nat.vs.Alk_DOWN.q95.list",
            quote = FALSE,
            sep="\t",
            row.names = FALSE,
            col.names = FALSE
)
