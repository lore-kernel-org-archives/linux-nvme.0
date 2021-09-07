Return-Path: <SRS0=5VvL=N5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38E8C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 21:30:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A59B610C9
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 21:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A59B610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rjrinLW0zB1wKDnxV3Yza5AytRc1jHX4AWxmcRlohpE=; b=Dx3pdNMWMJWyJm
	duEA8+C7hpABHuzUAV3LN7GQP/o3fRpcRH/U0cm5Ej3Ai+0IylXzw74xKmPFidjTzw4Bp5eC7WY8c
	x2uv6X52PRs0k312BlvQAkevuCRdisyf/CUpahm001qXlVwA5uT8y7rrO3mlesMgRahaet4liNzZ2
	c0AUoYLr1zIqvahNnXFL9WBWxWTdq4kdn/AfBLa2BJAaAyhr3pbxd2RpZMVqCVQoyQJnKiSPTDJVy
	rNNOn6CvbneM2PSWAGXesYp/K/do530QrqnO+oSy1DZDiN7dgrQXCFk70JMk5PliTl4d/600Toptp
	0ZZFbnqQORk5WvcvY99A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNiej-004m4D-It; Tue, 07 Sep 2021 21:29:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNieh-004m3l-1F
 for linux-nvme@lists.infradead.org; Tue, 07 Sep 2021 21:29:24 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3836460F43;
 Tue,  7 Sep 2021 21:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631050162;
 bh=lonuBQ4wtpFFKanSLDDNPL0mb4GDNZTGuCYFlLdkhUk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hBpih/WeYv1rbF5pJ9rA8ccqoRyCt0vFnnObxHO4qi5IzBUSNXVeRZhrG6VyyhuMe
 S01ZRFjHuO3o7ZXHe29WW/HbqNfreCf4BFPcdM0kD6ThfzShwUCeaPT+H/QxJUL6Yh
 1XdlqmwlOfIpzRDj1iMs1TjKlc/foME7NBJLJ0DHBHb3IldR+upN1NWrBP/jEdukew
 JLDtr+YVPHwnhgMEOWpP7VNpNz8FJR6q9G8AgN0AGIP83F2v0gSL6823goWvLn5X9j
 +CRlwS3FGCDny84GYBcpKMJVcxaTgxuZMSevf6a4296Ql5kDwLiZo2mlqHPVm8QxSJ
 ORpx9TEgN+Avg==
Date: Tue, 7 Sep 2021 14:29:20 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] fabrics: fix return value of hostnqn_read_file()
Message-ID: <20210907212920.GC591280@dhcp-10-100-145-180.wdc.com>
References: <20210906005719.296481-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210906005719.296481-1-chaitanyak@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210907_142923_136093_1F1F8780 
X-CRM114-Status: UNSURE (   9.34  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Sep 05, 2021 at 05:57:19PM -0700, Chaitanya Kulkarni wrote:
> @@ -855,7 +855,7 @@ static char *hostnqn_read_file(void)
>  
>  out:
>  	fclose(f);
> -	return ret;
> +	return strcmp(ret, "") == 0 ? NULL : ret;
>  }

But if the 'goto out' label is used, you are calling strcmp() with a
NULL pointer.

And if "ret" is an emptry string, I think you still need to free() it
here since it is not being returned anymore.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
