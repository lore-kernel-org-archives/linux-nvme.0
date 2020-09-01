Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984B2C433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:02:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B182071B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AH0NqRXw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="UIUfHbd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B182071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2MNGXVKJt4S1XrHDJgc/3x8CeldaLp1rbgo2lfaLDLI=; b=AH0NqRXwSbw1cdPrBsJ58mb5W
	/vpf3au+6tyWuI3EnZaS342YliEPauvpYWD5ehlRP+HZJbD4TGV12XdJwbWAJBPEJbxJNypCuPKwq
	/9yzaqXkMbHDJ/fzMGcTcLWYOVvNdO4+MsdXHWOO+tVFNkS5qbw1eaKKlpUz24RBPxzR4Zb1b1NIA
	o3RwlNoKvwJMNUe1+mqsNoHkraeI1Quy/0cmzm446vw47fb2smDtwEdvl8hClcBNzsW36hKy1Y0bA
	q5r8TIBp1DW9+rZBXWcgBhMFZWA4U8b4FjsHVLlX65IO4jIZpsp4IFjpxYHQu8MaINJLvPJzTAgRI
	HJ843NUtQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD9fb-0001Sr-IE; Tue, 01 Sep 2020 17:02:07 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD9fZ-0001SG-Cs
 for linux-nvme@lists.infradead.org; Tue, 01 Sep 2020 17:02:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q82R+2n4IEqOLlJVWOoYkiIE1gw4ZfPvmadc+Q75SsA=; b=UIUfHbd0aMlQ4Jv+xYvXmrAFOq
 6T54iPGqliy1vsHP+EboDoTNsMBQvTUw4kF5yULSmadZi5+ZV6TqwCyH0tN6oLB9fAtFSOfznhUuB
 amWZQZQw45Pw/QxIAHcHXCrf/epGA9P4h8qPXe7rpFbIEO2TUnDWbydMa9sGOMzbdoNP/LSIhYMQA
 aEeCTdIYWvtsLS4EJ/gSZyaeJlXuUAFMp9Mpg7eOxi7bhCYjwxDSf1iGELggAP3z1Bd87p/8I/P1M
 r9ug3YAs610BN4ZE37C/4o86M1vZ9FnVnkYQOeEPQwJ2fGMOFbJxAmt1gJm/kkUmRuG04EqaPoPoi
 rz+YDvOg==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kD9fU-0006fm-8D; Tue, 01 Sep 2020 11:02:01 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-9-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7310435c-5341-d95b-55e7-605c0dc7130e@deltatee.com>
Date: Tue, 1 Sep 2020 11:02:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831222707.35611-9-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
 linux-nvme@lists.infradead.org, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH V2 08/12] nvmet: move get/put ctrl into dev open/release
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_130205_440342_2B8A1F97 
X-CRM114-Status: GOOD (  19.87  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-31 4:27 p.m., Chaitanya Kulkarni wrote:
> Introduce nvme_dev_release ctrl file release callback and move ctrl get
> and put operations from target passthru into host core in ctrl open and
> release file operations respectively.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/core.c       | 12 +++++++++++-
>  drivers/nvme/target/passthru.c |  7 ++-----
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 425a3c16d5a5..f82c6a283b15 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3262,6 +3262,16 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
>  	}
>  
>  	file->private_data = ctrl;
> +	nvme_get_ctrl(ctrl);
> +	return 0;
> +}
> +
> +static int nvme_dev_release(struct inode *inode, struct file *file)
> +{
> +	struct nvme_ctrl *ctrl =
> +		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
> +
> +	nvme_put_ctrl(ctrl);
>  	return 0;
>  }
>  
> @@ -3327,6 +3337,7 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>  static const struct file_operations nvme_dev_fops = {
>  	.owner		= THIS_MODULE,
>  	.open		= nvme_dev_open,
> +	.release	= nvme_dev_release,
>  	.unlocked_ioctl	= nvme_dev_ioctl,
>  	.compat_ioctl	= compat_ptr_ioctl,
>  };

Seems like everything above this is necessary and fixes a real and
obvious bug and should go in separately, first.

Everything below this is rather unrelated to the bug...


> @@ -4651,7 +4662,6 @@ struct nvme_ctrl *nvme_ctrl_get_by_file(struct file *f)
>  	}
>  
>  	ctrl = f->private_data;
> -	nvme_get_ctrl(ctrl);
>  
>  out_close:
>  	return ctrl;
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index b121f532a6ff..20944c48095c 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -505,11 +505,11 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
>  			 subsys, GFP_KERNEL);
>  	if (xa_is_err(old)) {
>  		ret = xa_err(old);
> -		goto out_put_ctrl;
> +		goto out_put_file;
>  	}
>  
>  	if (old)
> -		goto out_put_ctrl;
> +		goto out_put_file;
>  
>  	subsys->passthru_ctrl = ctrl;
>  	subsys->ver = ctrl->vs;
> @@ -524,8 +524,6 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
>  	mutex_unlock(&subsys->lock);
>  	return 0;
>  
> -out_put_ctrl:
> -	nvme_put_ctrl(ctrl);
>  out_put_file:
>  	filp_close(subsys->passthru_ctrl_file, NULL);
>  out_unlock:
> @@ -538,7 +536,6 @@ static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
>  	if (subsys->passthru_ctrl) {
>  		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->cntlid);
>  		filp_close(subsys->passthru_ctrl_file, NULL);
> -		nvme_put_ctrl(subsys->passthru_ctrl);
>  	}
>  	subsys->passthru_ctrl = NULL;
>  	subsys->ver = NVMET_DEFAULT_VS;
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
