From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 29 Jun 2018 14:23:07 -0600
Subject: [PATCHv3 2/4] nvme: use hw qid in trace events
In-Reply-To: <20180629200000.16171-3-keith.busch@intel.com>
References: <20180629200000.16171-1-keith.busch@intel.com>
 <20180629200000.16171-3-keith.busch@intel.com>
Message-ID: <20180629202307.GA13865@localhost.localdomain>

On Fri, Jun 29, 2018@01:59:58PM -0600, Keith Busch wrote:
> +	    TP_printk("qid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
> +		      __entry->qid, __entry->nsid, __entry->cid, 

Ugh, the nsid and cid are swapped here, and carried through to the end
of the series. Will need to send a v4.
