From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 4 Apr 2014 12:31:23 -0400
Subject: [PATCH] NVMe: Increase shutdown complete time
In-Reply-To: <alpine.LRH.2.03.1404031709520.4731@AMR>
References: <1396283044-31926-1-git-send-email-keith.busch@intel.com>
 <alpine.WNT.2.00.1403311256420.4656@DMCLERAN-MOBL.amr.corp.intel.com>
 <49158E750348AA499168FD41D8898360626A03D9@FMSMSX105.amr.corp.intel.com>
 <alpine.WNT.2.00.1403311755300.4656@DMCLERAN-MOBL.amr.corp.intel.com>
 <90064137F935C142B4B98BA318BB81A301DA530C@GREEN-CLEX.greenliant.com>
 <alpine.LRH.2.03.1404031709520.4731@AMR>
Message-ID: <20140404163123.GE27299@linux.intel.com>

On Thu, Apr 03, 2014@05:12:34PM -0600, Keith Busch wrote:
> +int nvme_io_timeout = 5;
> +module_param(nvme_io_timeout, int, 0);
> +MODULE_PARM_DESC(nvme_io_timeout, "timeout in seconds for io submitted to queue");

Any reason not to make this module_param 0644?  That would allow it to
be written by root and read by anybody.
