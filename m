Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C2AC2BD09
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 08:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ZhLEfCa21F8VksVdYOxkxIpatpx1+Tdmao+uqS3ez0=; b=n1gK6zw7tVPEiPvNCpAxbRdZBh
	AFWjdous5Ow9EtiTLWa4ywiGWZcAEzn0Yaxh+2e0pfedVz53/zx7rHWC1ueuPKQTuI5PJdumm1OVW
	3prL2nn0uDDqSj1ktRmX1k3jMAybqFShb6sDytwZip8OKQ0hivc63oUBa/P4qNKPnCp1rklLrAMAO
	Fc9JEda9V5qaA503zPzQMqsXnZMTQn8/b13VOtKMRy7YLvQuOmQUVVRHFubjZLLXybUCCP1sN6rcT
	00EGjbFBv4znMrhfLdeyA0R/fdWKJZ3UwwRKOxkeuMZiQKyDAQ27+/VHWoP3b3I6ZvQ7rxYmNbpWx
	3vMaH/oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLfLP-0000000G6dP-1TlV;
	Mon, 24 Jun 2024 08:46:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLfLM-0000000G6ck-3n1m
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 08:46:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1D8A268B05; Mon, 24 Jun 2024 10:46:28 +0200 (CEST)
Date: Mon, 24 Jun 2024 10:46:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, jrani@purestorage.com, randyj@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH v7 1/1] nvme-multipath: implement "queue-depth" iopolicy
Message-ID: <20240624084627.GA20032@lst.de>
References: <20240619163503.500844-1-jmeneghi@redhat.com> <20240619163503.500844-2-jmeneghi@redhat.com> <20240620065641.GA22113@lst.de> <d4ae4b0a-b3a4-40db-87e3-c9a493408172@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4ae4b0a-b3a4-40db-87e3-c9a493408172@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_014633_127740_61EFFD32 
X-CRM114-Status: GOOD (  17.19  )
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

On Thu, Jun 20, 2024 at 01:54:29PM -0400, John Meneghini wrote:
>>> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys,
>>> +		int iopolicy)
>>> +{
>>> +	struct nvme_ctrl *ctrl;
>>> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
>>> +
>>> +	if (old_iopolicy == iopolicy)
>>> +		return;
>>> +
>>> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
>>
>> What is the atomicy model here?  There doesn't seem to be any
>> global lock protecting it?  Maybe move it into the
>> nvme_subsystems_lock critical section?
>
> Good question.  I didn't write this code. Yes, I agree this looks racy. 
> Updates to the subsys->iopolicy variable are not atomic. They don't need to 
> be. The process of changing the iopolicy doesn't need to be synchronized 
> and each CPU's cache will be updated lazily. This was done to avoid the 
> expense of adding (another) atomic read the io path.

Looks like all sysfs ->store calls for the same attribute are protected
by of->mutex in kernfs_fop_write_iter and we should actually be fine
here.  Sorry for the noise.

>> 	pr_notice("%s: changing iopolicy from %s to %s\n",
>> 		subsys->subnqn,
>> 		nvme_iopolicy_names[old_iopolicy],
>> 		nvme_iopolicy_names[iopolicy]);
>
> How about:
>
> pr_notice("Changed iopolicy from %s to %s for subsysnqn %s\n",
>                 nvme_iopolicy_names[old_iopolicy],
>                 nvme_iopolicy_names[iopolicy],
>                 subsys->subnqn);

Having the identification as the prefixe seems easier to parse
and grep for. 


