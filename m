From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Thu, 19 Jul 2018 16:22:07 +0530
Subject: [pci PATCH v8 4/4] pci-pf-stub: Add PF driver stub for PFs that
 function only to enable VFs
In-Reply-To: <20180420163109.46077.60334.stgit@ahduyck-green-test.jf.intel.com>
References: <20180420162633.46077.49012.stgit@ahduyck-green-test.jf.intel.com>
 <20180420163109.46077.60334.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <CA+sq2CdDuimDCYK+9arO7-oRpNxdynX+rqYwpeBi9C_R+4pQNw@mail.gmail.com>

Hi,

> +static struct pci_driver pf_stub_driver = {
> +       .name                   = "pci-pf-stub",
> +       .id_table               = pci_pf_stub_white_list,
> +       .probe                  = pci_pf_stub_probe,
> +       .sriov_configure        = pci_sriov_configure_simple,
> +};
> +

Is there any specific reason for not disabling SRIOV upon driver unload/remove ?

i.e if a user sets numVFs to a non-zero value and unloads this driver
then we have a
situation where there is no PF driver in kernel but VFs still exist.

Thanks,
Sunil.
