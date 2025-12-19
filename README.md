## U3-Nomogram for C-CAT CALICO database <img src="source/MANO.png" width=50>
Germline-foc**U**sed analysis of t**U**mo**U**r-detected variants with **Nomogram** for C-CAT CALICO database.  
Copyright (c) 2025 Masachika Ikegami, Released under the [MIT license](https://opensource.org/license/mit).  

## Paper
> M. Ikegami et al., "Germline pathogenic variant prediction model for tumor-only sequencing based on Japanese clinicogenomic database ", Clin Cancer Res, 2025. [https://doi.org/10.1038/s42003-021-02930-4](https://aacrjournals.org/clincancerres/article-abstract/doi/10.1158/1078-0432.CCR-25-2985)

## Press release in Japanese
> [Press release from National Cancer Center, Japan, 2025/12/18](https://www.ncc.go.jp/jp/information/researchtopics/2025/1218_2/index.html)

### Trial Germline-origin Prediction Website
You can check the prediction model of v3.0.1 on this server (https://www.felis-portal.com/U3Nomogram/).  

### Web Application for Germline Variant Analysis Using the C-CAT CALICO Database
The Center for Cancer Genomics and Advanced Therapeutics (C-CAT) at the National Cancer Center Japan aggregates results from cancer genomic profiling (Comprehensive Genomic Profiling, CGP) tests performed under insurance coverage, along with associated clinical information. A system exists for secondary utilization of this information for academic research and drug development purposes. Currently, access requires ethical review approval from both the affiliated institution and C-CAT. For non-hospital and non-academic organizations, an annual usage fee of 7.8 million yen is required, creating a high barrier to entry. However, compared to similar international databases such as AACR Project GENIE, C-CAT excels in providing detailed drug and clinical information, enabling novel analytical approaches for rare cancers and rare molecular fractions that were previously not feasible.  
Working with C-CAT data presents unique challenges inherent to big data and real-world data analysis, and requires a certain level of programming knowledge for data processing. We developed this software to lower the barrier to analysis through a GUI-based interface, facilitating exploratory research based on clinical questions arising from physicians' daily practice and promoting the utilization of C-CAT secondary-use data.  
The C-CAT database consists of two components: the Secondary Use Search Portal, which provides access to curated report information returned to patients by testing companies, and the Secondary Use Cloud C-CAT CALICO (CALculation & Investigation ClOud), which provides access to sequence data (CRAM files) from testing companies. Currently, CALICO has extremely restricted access, which is quite unfortunate.  
Please understand that currently only those who can obtain data from C-CAT CALICO can use this software. After publication as a peer-reviewed article, we expect it will become freely available.  
### Analysis Methods Are Based on the Following Publication
Ikegami M et al., Germline pathogenic variant prediction model for tumor-only sequencing based on Japanese clinicogenomic database, in submission.  

### Recommended U3-Nomogram Versions for Each C-CAT CALICO Database Version
Since C-CAT data may have column names added or modified with each version, compatible versions are required.  
C-CAT CALICO database version 1 (~20240216): U3-Nomogram version 1.8.1  

### Acknowledgments
This software is dedicated to Yu Ikegami, who supported its development.  
