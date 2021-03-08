Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D89C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 16:32:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48F765241
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 16:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48F765241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dtiIzy+9kc5MY5Qk54moohocjiahdx2hku1751Xg9F4=; b=llp0BCKdI8ib8W3fti0M2a3k8
	BY1SxueUtr/hnX3gcyu9ADgkYf0Sb2cW7F/Gwn44zd4AzhMdAm3IsvrCv+wCNdmCIxsrQ9Qj4x0Pv
	65Mfd7grtlUqk3RDys0B4oxXj2XIcvo92Lro0Y5Zfc2c9yhZZ0mPWXeeQqcp9bEgbd5HfchgbNxHX
	XpyN4/ivydpJmcpCpX+63KGwy31XLSg/CqtlempBB3+ozmyNAxDCT7toSFSgIrw5J7cH7JIxGcK8A
	OVCv78Enf8Z+O6sHhEFPpwUdUyJq/OBkCTdlLUY0526U5jFelFyBI0+2wwOC4QSwY5xxkBFvzhwaF
	Pi3rB2W0g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJIo9-0013Ux-Ls; Mon, 08 Mar 2021 16:32:37 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJIo5-0013S1-HW
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 16:32:35 +0000
Received: by mail-wr1-x42c.google.com with SMTP id f12so12108024wrx.8
 for <linux-nvme@lists.infradead.org>; Mon, 08 Mar 2021 08:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZhOIRRujtFql++R7kmG02ewhcSqkxodqDPwoZ1eINpo=;
 b=s7wwq7JPPm2U1+kZoiOap2OUsbwEZfRdvx0TrHnwyLQyMSZ5uHl5lEuLvJ+BHtLMt+
 10ZoFBK0PutMHQZ5G3D32MZDKWAf7OXnot/y6G7ywuGYwzJ17lF0xdlJrMjJ2zy1bNF3
 NGgSg/VKMPE0iBnhkB4ViUDxna67TjydDcYH4Dd9a+BImWf9f7IpaBEsAYRT38BTDzUa
 cXwfBTr5rvtiL52eyUMSTdo8kVKje69qLiaZ80jA8RKr+9RbrhIDnMEuPJoN67oI+yo3
 KBbfo2J47bTBmB3rtu/ZYxTxEZjrb2XfOtEGgznjZ2qdl9OlDGpRoUXv/pAQZ/6V2prG
 eNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZhOIRRujtFql++R7kmG02ewhcSqkxodqDPwoZ1eINpo=;
 b=rZJ0lGaPlOdJF6dDzoU9gJH2xSUGBEA3O561e6D5kP5OgCN3qCYf3WXDk6Wke5Cjkp
 Nc0L77iFNIbpobhpiVnD8pWQQsAAARRyo401mxmWDq7a3pzf1v2QkBRPr/6CyGK9EJ6E
 it9oiuSkQAJxh+uUqIo/mxbtw52dl0bAC9e/IrCJws9DFjZI/4Np8ab9kRKCydcVMI98
 fCG13h50mqvf9eQk0pG5Nc5G82MP+VlVUWYnEUxQTvH2oNiylZv4GBm44kIf51cHrf1Q
 furcY0R7Ba5v718mvmKhOG5lJRzA5et0PbZQ0KRk4EMzsBuo1e/NN9gGVBiDdyKluyUq
 WJ7Q==
X-Gm-Message-State: AOAM533QE3j072U9VF674vy6tNgcGU1eJNL3uOqfgbmqd/bzuIDI/eOl
 IXMCn5aZZcZy6ja24LWZDko2jHpRXhBnJK+yBtg=
X-Google-Smtp-Source: ABdhPJzUX5jh+8XN3AYCtdSJbFzW4c6ZYr1TPWIt4/x+IRTr/PSoT9pHIlJUxXmRsuDJpf1wcqDs0A2p/fLPe4njtcY=
X-Received: by 2002:a5d:5906:: with SMTP id v6mr23932781wrd.137.1615221152420; 
 Mon, 08 Mar 2021 08:32:32 -0800 (PST)
MIME-Version: 1.0
References: <20210308104226.165814-1-niklas.cassel@wdc.com>
In-Reply-To: <20210308104226.165814-1-niklas.cassel@wdc.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 8 Mar 2021 22:02:05 +0530
Message-ID: <CA+1E3rLY_FrjhXSFr4_V0OEiv6uFnD4bvY-XLyi9O4C3n_0CGA@mail.gmail.com>
Subject: Re: [PATCH] Revert "nvme: cleanup zone information initialization"
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_163233_783232_1E1AB378 
X-CRM114-Status: GOOD (  10.38  )
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

On Mon, Mar 8, 2021 at 4:21 PM Niklas Cassel <Niklas.Cassel@wdc.com> wrote:
>
> From: Niklas Cassel <niklas.cassel@wdc.com>
>
> This reverts commit 73d90386b559d6f4c3c5db5e6bb1b68aae8fd3e7.
>
> Commit 73d90386b559 ("nvme: cleanup zone information initialization")
> introduced the following warning at boot:
> WARNING: CPU: 0 PID: 7 at block/blk-settings.c:252 blk_queue_max_zone_append_sectors+0x7d/0x90
>
> The warning is the result of chunk_sectors being 0.

This looks same as what Chaitanya posted the fix for -
https://lore.kernel.org/linux-nvme/20210303224717.51633-1-chaitanya.kulkarni@wdc.com/

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
