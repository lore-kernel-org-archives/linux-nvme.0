Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FCDC4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Apr 2024 07:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ld7I3eWmGvNLa7PrPodmdYAMZ9M4QgcOzaMJX0EnNt0=; b=Z0S1SCQJyWUf380INYqMFLYO7T
	HCrPbW1BTYLesBZ8kzq6fUOKq8HhKDaSqSlBBuNL/1nqz2IFe46eppoBqy6nS6vHO0vEQsPYa74dy
	rLkIvoZYoCEUMQvuEwc57ebUADhXY0qmj4YQQHXsLmFGsfLrTr88Afq8Djze6jrwfWSLX0tdNxhdN
	s7DaWXkXVXfEgbhpOEtmmUPFSHw7pS76jOVMU9T4pGzHh2SRHvo9fLyY9gJKdDvYOwwH5/Nl6rx+i
	soKant/w/qKwLjwsN5AZlS9OLU0rKqkvncoCcnC562H2sCyn2xBTPnJPS50B3MgatMCBT+6LhwPOs
	qF16NrXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwGiu-00000007KyN-42J4;
	Mon, 15 Apr 2024 07:25:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwGir-00000007Kwr-22Mk
	for linux-nvme@lists.infradead.org;
	Mon, 15 Apr 2024 07:25:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BD2DD68BEB; Mon, 15 Apr 2024 09:25:30 +0200 (CEST)
Date: Mon, 15 Apr 2024 09:25:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, gjoyce@linux.ibm.com, axboe@fb.com
Subject: Re: [PATCH] nvme: find numa distance only if controller has valid
 numa id
Message-ID: <20240415072530.GA31958@lst.de>
References: <20240413090614.678353-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413090614.678353-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_002549_695573_1E5A0BA0 
X-CRM114-Status: GOOD (  12.00  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Apr 13, 2024 at 02:34:36PM +0530, Nilay Shroff wrote:
>  			continue;
>  
> -		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
> -			distance = node_distance(node, ns->ctrl->numa_node);
> -		else
> -			distance = LOCAL_DISTANCE;
> +		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA) {
> +			if (ns->ctrl->numa_node != NUMA_NO_NODE)
> +				distance = node_distance(node, ns->ctrl->numa_node);
> +		}

Please avoid the overly long line.  This could be easily done by keeping
the old code structure, which IMHO is more readable anyway:

		if (ns->ctrl->numa_node != NUMA_NO_NODE &&
		    READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
			distance = node_distance(node, ns->ctrl->numa_node);
		else
			distance = LOCAL_DISTANCE;


