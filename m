From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 14 Oct 2015 18:42:53 -0400
Subject: [PATCH 2/5] block: Consolidate static integrity profile properties
In-Reply-To: <1444852846.3409.8.camel@intel.com> (Dan J. Williams's message of
 "Wed, 14 Oct 2015 20:00:47 +0000")
References: <B58D82457FDA0744A320A2FC5AC253B93CBE5758@fmsmsx104.amr.corp.intel.com>
 <1444683912-7140-1-git-send-email-martin.petersen@oracle.com>
 <1444683912-7140-3-git-send-email-martin.petersen@oracle.com>
 <CAPcyv4it_ju8JoNcmG7K3yiKyzS_hEsNRYhiLrU1ZvqfQHjVXw@mail.gmail.com>
 <20151014072303.GA2544@infradead.org>
 <1444851760.3409.6.camel@intel.com>
 <20151014194732.GA14724@infradead.org>
 <1444852846.3409.8.camel@intel.com>
Message-ID: <yq1k2qpjclu.fsf@sermon.lab.mkp.net>

>>>>> "Dan" == Williams, Dan J <dan.j.williams at intel.com> writes:

Dan> The libnvidmm-btt and nvme drivers use blk_integrity to reserve
Dan> space for per-sector metadata, but sometimes without protection
Dan> checksums.  This property is generically useful, so teach the block
Dan> core to internally specify a nop profile if one is not provided at
Dan> registration time.

Looks good to me.

Acked-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
