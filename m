From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Tue, 15 Mar 2016 14:43:00 +0100 (CET)
Subject: [PATCH v2] nvme: avoid cqe corruption when update at the same
 time as  read
In-Reply-To: <20160315133002.GA15981@infradead.org>
References: <2110767714.5479030.1458045053603.JavaMail.zimbra@kalray.eu>
 <20160315133002.GA15981@infradead.org>
Message-ID: <1529469492.5542568.1458049380052.JavaMail.zimbra@kalray.eu>

----- Le 15 Mar 16, ? 14:30, Christoph Hellwig hch at infradead.org a ?crit :

>> +/* We read the CQE phase first to check if the rest of the entry is valid */
>> +static inline bool nvme_cqe_valid(struct nvme_queue *nvmeq, u16 head,
>> +	u16 phase)
> 
> the second line here would normally get a two tab indent.
> 
> 
> Except for this minor nitpick this looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>

I'm resending with this minor modification. Thanks!
