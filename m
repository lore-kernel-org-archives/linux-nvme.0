Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C18CC47074
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 17:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iJzEAwyjCuTLPKgXGoF6ca3ZkqLfiVvQhNO837eVsVY=; b=0BhFAdinAV46bTG86pg/Skd/YC
	3PX4BYIgbIDmE2QPyy1EmDZVyPTLrpstN3ymJwYhZvn3pw49ycG8BiCGv6DeJHk3M+VjZTi5ey2fI
	A+BW3xPi2CG5HehKdix2DQu3ZNuuCsN5oWugiKgGJW8rZVR/CykpHUkxt6uwYszszs9VtxBzl5Nom
	n4cdmW7SZOYA278pK3FREPOhYrnfE+GOU1ml7ET+K3rzJ3FtgF7zxrgX+JbNF2bTB0eI7eRX6EnWe
	jrkwmVoWwJCthQ02lfhV29rNp7BPEWas3DD+txAGmduiku4wltN57H1Tnljp2z3taWztJEe1f31Mb
	pUtv//+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLRkr-00EsNH-0i;
	Thu, 04 Jan 2024 17:43:41 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLRkn-00EsKq-2B
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 17:43:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=iJzEAwyjCuTLPKgXGoF6ca3ZkqLfiVvQhNO837eVsVY=; b=skkilULKM8C/9Hywx1jdonlgqN
	++A6RTzwGnMDi8BokpQmF4HobsEF2UuRLnA9rdOqmkXdYJhtq4C+h23liOymxB8dgTZq4knIupRQT
	HmYozwkwpUH4RrW9N3mmvCE1ERzpNO3oHJvyKxSEclttWmUYSwN7hNqpKG8e3OkOyClV/sMuhog4h
	Tl2+U/Ix+STXYwYUsvsGQV69yGYSonefWms+1VvprHCzmfBqPYwcEMkeDioBxUJaAJFivI11renOf
	5VE60euPAWSGPloeZs5TI3FXE5XOGZoiXhexPZvXFJS0ng0Cv7/wtcrZbVo3P0wBQpAzqVDyMlC79
	ald4JFBWzphXoXPCkEphypP/UN7n/yDXDfwMstrIoqBkueXaOqf6ktsRggABHtveYXiFruCGEa5DV
	icawfJnLoMlVQFAXU4mA7o7gaCVIdazYD+JFm4OoHeYKH7TBz2SHKrSV5csM8+JGLyM5eNeqyUzvh
	YLpP/L2yEwjVQ18ofpSpA+8V;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rLRkk-006TMe-1G;
	Thu, 04 Jan 2024 17:43:34 +0000
Date: Thu, 4 Jan 2024 09:43:30 -0800
From: Jeremy Allison <jra@samba.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org, jra@samba.org
Subject: Re: [PATCH 3/5] nvme: Change 'bool shutdown' into an enum
 shutdown_type.
Message-ID: <ZZbuQsCg6jXMjl2u@jeremy-HP-Z840-Workstation>
References: <20240103210405.3593499-1-jallison@ciq.com>
 <20240103210405.3593499-4-jallison@ciq.com>
 <4486c671-af66-4466-bfca-e184584d884b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4486c671-af66-4466-bfca-e184584d884b@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_094337_730094_AC1B34CD 
X-CRM114-Status: GOOD (  15.58  )
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
Reply-To: Jeremy Allison <jra@samba.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 04, 2024 at 03:26:11PM +0200, Sagi Grimberg wrote:
>
>
>On 1/3/24 23:04, Jeremy Allison wrote:
>>Convert nvme_disable_ctrl() and nvme_dev_disable()
>>inside drivers/nvme/host/pci.c to use this:
>>
>>bool shutdown = false == NVME_DISABLE_RESET
>>bool shutdown = true == NVME_DISABLE_SHUTDOWN_SYNC.
>>
>>This will make it easier to add a third request later:
>>NVME_DISABLE_SHUTDOWN_ASNYC
>>
>>As nvme_disable_ctrl() is used outside of drivers/nvme/host/pci.c,
>>convert the callers of nvme_disable_ctrl() to this convention too.
>>
>>Signed-off-by: Jeremy Allison <jallison@ciq.com>
>>---
>>  drivers/nvme/host/apple.c  |  4 ++--
>>  drivers/nvme/host/core.c   |  6 +++---
>>  drivers/nvme/host/nvme.h   |  7 +++++-
>>  drivers/nvme/host/pci.c    | 44 +++++++++++++++++++-------------------
>>  drivers/nvme/host/rdma.c   |  3 ++-
>>  drivers/nvme/host/tcp.c    |  3 ++-
>>  drivers/nvme/target/loop.c |  2 +-
>>  7 files changed, 38 insertions(+), 31 deletions(-)
>>
>>diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
>>index 596bb11eeba5..764639ede41d 100644
>>--- a/drivers/nvme/host/apple.c
>>+++ b/drivers/nvme/host/apple.c
>>@@ -844,8 +844,8 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
>>  		 * NVMe disabled state, after a clean shutdown).
>>  		 */
>>  		if (shutdown)
>>-			nvme_disable_ctrl(&anv->ctrl, shutdown);
>>-		nvme_disable_ctrl(&anv->ctrl, false);
>>+			nvme_disable_ctrl(&anv->ctrl, NVME_DISABLE_SHUTDOWN_SYNC);
>>+		nvme_disable_ctrl(&anv->ctrl, NVME_DISABLE_RESET);
>>  	}
>>  	WRITE_ONCE(anv->ioq.enabled, false);
>>diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>index 50818dbcfa1a..e1b2facb7d6a 100644
>>--- a/drivers/nvme/host/core.c
>>+++ b/drivers/nvme/host/core.c
>>@@ -2219,12 +2219,12 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
>>  	return ret;
>>  }
>>-int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
>>+int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type)
>>  {
>>  	int ret;
>>  	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
>>-	if (shutdown)
>>+	if (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC)
>>  		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
>>  	else
>>  		ctrl->ctrl_config &= ~NVME_CC_ENABLE;
>>@@ -2233,7 +2233,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
>>  	if (ret)
>>  		return ret;
>>-	if (shutdown) {
>>+	if (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC) {
>>  		return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
>>  				       NVME_CSTS_SHST_CMPLT,
>>  				       ctrl->shutdown_timeout, "shutdown");
>>diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>index 6092cc361837..1a748640f2fb 100644
>>--- a/drivers/nvme/host/nvme.h
>>+++ b/drivers/nvme/host/nvme.h
>>@@ -187,6 +187,11 @@ enum {
>>  	NVME_MPATH_IO_STATS		= (1 << 2),
>>  };
>>+enum shutdown_type {
>>+	NVME_DISABLE_RESET = 0,
>>+	NVME_DISABLE_SHUTDOWN_SYNC = 1
>>+};
>
>I also don't find this a bit awkward especially when another
>enumeration value is added later on.
>
>An alternative approach would be to stick with nvme_disable_ctrl that
>accepts shutdown bool, and add nvme_disable_ctrl_nowait() wrapper for it
>that call-sites can use. Or even better, because we only have a nowait
>variant for shutdown, perhaps we can add nvme_shutdown_ctrl_nowait()
>wrapper that accepts only the ctrl instead (this will require splitting
>nvme_disable_ctrl to the disabling phase and the waiting phase, but that
>is hidden in the core as static functions).

OK. Let me take a look at this. It would certainly remove the
changes in unrelated files such as drivers/nvme/host/apple.c,
drivers/nvme/host/tcp.c and drivers/nvme/target/loop.c.

This change might take me a little longer to get right, so
please bear with me.

