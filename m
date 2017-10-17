From: pmenzel@molgen.mpg.de (Paul Menzel)
Date: Tue, 17 Oct 2017 22:33:56 +0200
Subject: How to improve long suspend time in `nvme_shutdown_ctrl`
Message-ID: <72b666c9-dd57-ef87-e89e-ba280f34e90c@molgen.mpg.de>

Dear Linux folks,


Instrumenting ACPI S3 suspend time with AnalyzeSusend [1] on Linux 
4.14-rc5 on a TUXEDO Book BU1406 shows that 338 ms are spend in nvme.

> nvme @ 0000:04:00.0 {nvme} async_device (Total Suspend: 356.823 ms Total Resume: 20.148 ms)
```
$ lspci -nn -s 4:00.0
04:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co 
Ltd NVMe SSD Controller SM961/PM961 [144d:a804]$ sudo 
./analyze_suspend.py -config config/suspend-callgraph.cfg
```

 From the HTML output:

> nvme_shutdown_ctrl [nvme_core] (321.044 ms @ 476.668326)
> ? nvme_pci_reg_write32 [nvme] (0.000 ms @ 476.668327)
>   nvme_pci_reg_read32 [nvme] (0.033 ms @ 476.668329)
>   msleep (104.991 ms @ 476.668363)
>   nvme_pci_reg_read32 [nvme] (0.004 ms @ 476.773356)
>   msleep (107.992 ms @ 476.773361)
>   nvme_pci_reg_read32 [nvme] (0.001 ms @ 476.881355)
>   msleep (108.009 ms @ 476.881357)
>   nvme_pci_reg_read32 [nvme] (0.001 ms @ 476.989367)

Is that the right register to read? Can this be improved? If not, is 
that a firmware bug?


Kind regards,

Paul


[1] https://github.com/01org/pm-graph
