Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275ACC47DD3
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jan 2024 04:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1UeEjYigGgDRDsvfenbDnt7IPq8BVo5fEUV9fATgUnc=; b=lhasjNVRzHRiOFimSKWbTK+a1O
	MEjrJzoAuyogU8LmVIZaXXf5cSfWlZtCEernDexTT/Cf/6xSlJirvresGLtwtGtMbIttljgctFldY
	/KIY3tmqyk0i14tAlpmSeG0siYyZNrAhUNxdV5Csu8pX0f5jwuYMoZVQYkO0Oi0hR5q5tbshE9qNu
	a2sMKfP+n54lgfwdD2tWuqi2ymkYXnI1sglMZcOIflJ+Vxtfr+C0+U/kKRafM9uCJSwb1Xxp22C1t
	BJ6Q1I20NKStfKJ8Qo1XWiY4OnPIaQeOudmaoITupyJUUzqeSa7KaC5DBZwks1rZBu6J3jsnSDPdw
	hRqrnPxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQgnh-004TDz-1X;
	Fri, 19 Jan 2024 04:48:17 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQgnd-004TCj-3C
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jan 2024 04:48:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 005CFB811BE;
	Fri, 19 Jan 2024 04:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2178BC433F1;
	Fri, 19 Jan 2024 04:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705639686;
	bh=2zMwRd++WGHO/dzFJ8oPHiUxD0AI5KxVbZ4Jm8rX+50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fM89tsepURNVeAZMjmdtYRyZjjLAd/QfOS3pzh/OnTAX7APvs+FEdqj+KWtmysfoh
	 AOpbM4gfq/nw5pcxS30EedesQ3Iat1omHxgzeHq3a25R6aKX203B/jLZKzB6KSXcY7
	 49m0qLHs9C8CEqPDAk0Y2wiRBRo7U6jLW89VGPl0DVT95qo6RJFHBIJYzKoHETrCQo
	 LsdI9tkLeZgmkA3Es31W+4C6V9yu8s2IsdH+b8qtTbfQcQl7H0D75YeUaJoPjrs9DT
	 fGHHLCSATDC0DgbzzoCHmym56Yqls7k9pO5sQ+mjHG0Rd7/NxRbyO748+00y/isRFe
	 5JhC39M15Db7A==
Date: Thu, 18 Jan 2024 21:48:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: alan.adamson@oracle.com
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, linux-block@vger.kernel.org
Subject: Re: [RFC 0/1] nvme: Add NVMe LBA Fault Injection
Message-ID: <Zan_A-dR5ReYTfBF@kbusch-mbp.dhcp.thefacebook.com>
References: <20240116232728.3392996-1-alan.adamson@oracle.com>
 <20240118072419.GA21315@lst.de>
 <6874a81c-3f4f-428a-8a95-19898ca004a2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6874a81c-3f4f-428a-8a95-19898ca004a2@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240118_204814_190657_F3C201EF 
X-CRM114-Status: GOOD (  16.19  )
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

On Thu, Jan 18, 2024 at 09:02:43AM -0800, alan.adamson@oracle.com wrote:
> 
> On 1/17/24 11:24 PM, Christoph Hellwig wrote:
> > On Tue, Jan 16, 2024 at 03:27:27PM -0800, Alan Adamson wrote:
> > > It has been requested that the NVMe fault injector be able to inject faults when accessing
> > > specific Logical Block Addresses (LBA).
> > Curious, but who has requested this?  Because injecting errors really
> > isn't the drivers job.
> 
> 
> It's an application (database) that is requesting it for their error
> handling testing.

Going out on a limb here... This seems so obscure to burden a driver to
synthesize. Could we just give a hook for a bpf override and you can
totally go for whatever scenario you can imagine with a script?

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 50818dbcfa1ae..df87a63335aa8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -381,9 +381,22 @@ static inline void nvme_end_req_zoned(struct request *req)
 	}
 }
 
+#ifdef CONFIG_BPF_KPROBE_OVERRIDE
+static noinline blk_status_t nvme_req_status(struct nvme_request *req)
+{
+	return nvme_error_status(req->status);
+}
+ALLOW_ERROR_INJECTION(nvme_req_status, ERRNO);
+#else
+static inline blk_status_t nvme_req_status(struct nvme_request *req)
+{
+	return nvme_error_status(req->status);
+}
+#endif
+
 static inline void nvme_end_req(struct request *req)
 {
-	blk_status_t status = nvme_error_status(nvme_req(req)->status);
+	blk_status_t status = nvme_req_status(nvme_req(req));
 
 	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET)))
 		nvme_log_error(req);
--

