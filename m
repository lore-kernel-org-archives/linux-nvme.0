From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 6 Nov 2012 11:32:13 -0500
Subject: [PATCH] NVMe: Free cmdid of nvme_submit_bio error
In-Reply-To: <1343937959-7836-1-git-send-email-keith.busch@intel.com>
References: <1343937959-7836-1-git-send-email-keith.busch@intel.com>
Message-ID: <20121106163213.GB1736@linux.intel.com>


Fixed it slightly differently (changed free_cmdid() to allow for fn to
be NULL).  But I kept your attribution and added an explanation.
