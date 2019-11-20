Return-Path: <SRS0=lFsX=ZM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93CAC432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 08:28:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2E122312
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 08:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j1RIvOKu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V12NSOnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2E122312
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=zi1k8CYN1UCgDFKTsA3clLxSKK+LY+kMLk2DsGiFW8Y=; b=j1R
	IvOKufDsQWNoJpIYJT3g6XglIt8I+04j9YdGFZlvYtTutIULzWt7hlmpo1MbLE1WEg6kvdxivKKed
	yejrEG0iW48g5B1bbi2R+eJzAgSWspH/Nm6n8+UAxgRHGSc2D7i9yGHgxl74B/qHAJJYiTnOIiAx3
	fJmCbiU7zrKFTc/u/E5iu0GTQ5HJ8jMHmh7xUEARw8PHbanOucNrJi20D60bzTa2s40zViJy3RFdn
	90UZUvIEvk4cjt3i904vrgsoGhN1hXwgCmkFnZfT+WxGmxeQqPCHflQyMQEMJ6GwLE2hbwc0+pVJA
	CMrYnuSPib7FMZlxqEMlk3YxsUkZFRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iXLLy-0001tw-0d; Wed, 20 Nov 2019 08:28:46 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXLLt-0001tK-KH
 for linux-nvme@lists.infradead.org; Wed, 20 Nov 2019 08:28:45 +0000
Received: by mail-pf1-x434.google.com with SMTP id q13so13858545pff.2
 for <linux-nvme@lists.infradead.org>; Wed, 20 Nov 2019 00:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=rCNVNOJsB/ljC4tu1rXzX1Rn7Hu77e5LhvljQJwkVTM=;
 b=V12NSOnEbcali4adLELPG0DbDLGMlmJoM0LdL5XCYAHZbdHLLG9a592ORzHQpaDRFI
 oG1RVP3znOM3YrnViPZU6GS0L7gqsAhVIzFBGDoHSBh9if92yaVPJFRKwpJq5bbwbEoK
 Ix2sIVY7XI+i0iNjbyDyhXUxAJUo6brxsUC73eXax+3TIYNmVwRwQoQb5OQYBFIc1zRr
 DQHQYfIZTM5ynK2BkD8ID7xww5ZiHqf0NrXxibW/qDdzpjHF2rG1fpRwS8GLfIhxRpKW
 mF7WCKdWCeVJ6WQH6oXezAP3LwZ9Q+pvwE/KMJNOHUOlYLoYwKKUvee3JSk/CEP/Sk3b
 WZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=rCNVNOJsB/ljC4tu1rXzX1Rn7Hu77e5LhvljQJwkVTM=;
 b=FCFIit9wj9mLdmi0Dqd/So1m4g72Zaz3sLiB5iRYZSodFQ/ekYqBXNR41ca5+uv7Zb
 sycgtW2uroOs/KxRIz3FfVmu8DJMfoekmR110UnNppjzDSMjYx1PXGrLKb2J57RIH65z
 OwInJn0pnCjKOGCQFeXJDZZycxEQAG0EtNk2dP/eb+drPlWKfj4ra0oX52iPRArFqTAg
 0LJO0+FatJacSVMiOhfkIMaONsUtk+1pxwQQ6VfALpOiFZsQ/Np8Tam+GGvFb1HVFy54
 OG+zqcrYwfU7ldtu/mN3sLUHdYEdegNrfLYvrNHZ2Ji48t9vgcYts6gysU2ABqhKkcac
 CH0A==
X-Gm-Message-State: APjAAAXzBe9ntvZACBI1YJn8SizFqe3eFde80/MTXN3XuSuMuQTUu0QE
 PR9mAvHbPWFevkCnPp7PM85HtNFG2bYDxLCx/iUJPgEZmok=
X-Google-Smtp-Source: APXvYqzURIm+XVhb/FgMd4+lCoMwNLhEydLuU61IJnjCXM5tPMHHDocKgSgE10jA2OXMeES1QQQnuKwxemrkxk0qszM=
X-Received: by 2002:aa7:828c:: with SMTP id s12mr2461697pfm.166.1574238520649; 
 Wed, 20 Nov 2019 00:28:40 -0800 (PST)
MIME-Version: 1.0
From: Sushil <sushil32@gmail.com>
Date: Wed, 20 Nov 2019 13:58:29 +0530
Message-ID: <CAOoKxP99U8E=oAY23wA4_JVQNbPXVnkpcL6_-_zcwCnYDCoBaQ@mail.gmail.com>
Subject: NVM Sets supported on Linux?
To: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191120_002843_996681_F2F7DC9B 
X-CRM114-Status: UNSURE (   5.98  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi All,

Are NVM Sets supported on Linux (Endurance, PLM etc)?
I could find the userspace command option "id-nvmset" (and the ioctl
NVME_ID_CNS_NVMSET_LIST) in the nvme-cli,
but nothing in the Linux kernel host and target.

Thanks,
Sushil.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
