Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA43FC43334
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jun 2022 07:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tzaPCHJRb/DkDnH7k4z9ObKlQfnmxtLZNf2DCMpBFm0=; b=DQ70mib8o/bsH/gIpgXXBFU1tA
	kj+GDwhaPSir9Q2xi7QmxP0ItLhkr/5aywEvU32fxMJ/HhfuSBgS/Oj3EJyTahqvzvMXeJVJ64lrX
	X+aVWXCXRnculbh4Q4ZXJNbrIN9njKfICUnpvjsBAnim+TsUC+527QrRDK6RZ35OJwyovLmFvH5Nu
	UUzAsNQSr/HiZCW0jlSFnpwnN1565063mROLdoMMQ+X+VZEGPeSIETfPie0mbjsc3HtX1ZRuG/m6e
	Y+5Ymc4qxGYRYsd4gaQD78NIbflW26WOn93MOqT4etGGdzYJ9NoHdf8LHAxYZtAeCSx98vcEoaUx5
	jCCPma7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyqUu-00Bm2A-KB; Wed, 08 Jun 2022 07:53:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyqUs-00Bm0p-9v
	for linux-nvme@lists.infradead.org; Wed, 08 Jun 2022 07:52:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 51FC968AA6; Wed,  8 Jun 2022 09:52:53 +0200 (CEST)
Date: Wed, 8 Jun 2022 09:52:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <20220608075252.GB13027@lst.de>
References: <Yk+KO8hEYpnKdGu3@garbanzo> <20220408052907.GA31990@lst.de> <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com> <20220408161052.GA28661@lst.de> <YlB1E/p1uqpl3HiN@bombadil.infradead.org> <20220411050533.GB13927@lst.de> <20220411055455.GA14480@lst.de> <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com> <20220420073641.GA6859@lst.de> <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220608_005258_575402_4FBB9049 
X-CRM114-Status: GOOD (  17.02  )
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

On Mon, Jun 06, 2022 at 08:35:39PM +0000, Alan Adamson wrote:
> nvme driver changes:

Thanks! 

>  
>  	ret = nvme_global_check_duplicate_ids(ctrl->subsys, ids);
>  	if (ret) {
> -		dev_err(ctrl->device,
> -			"globally duplicate IDs for nsid %d\n", nsid);
> -		return ret;
> +		if (ctrl->opts && ctrl->opts->clear_ids) {
> +			uuid_copy(&ids->uuid, &uuid_null);
> +			memset(&ids->nguid, 0, sizeof(ids->nguid));
> +			memset(&ids->eui64, 0, sizeof(ids->eui64));
> +		} else {
> +			dev_err(ctrl->device,
> +				"globally duplicate IDs for nsid %d\n", nsid);
> +			return ret;
> +		}

I don't think this is the right place to clear the reported IDs.
The proper place would be in the target code in
nvmet_passthru_override_id_ns and a new
nvmet_passthru_override_id_ns_desc like it.  Otherwise we only catch
the kernel driver uses and not other users of the IDs.

> @@ -593,6 +595,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>  			}
>  			kfree(opts->transport);
>  			opts->transport = p;
> +			if (!strcmp(p, "loop"))
> +				opts->clear_ids = true;

And maybe add a comment here.


