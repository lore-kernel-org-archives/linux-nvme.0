Return-Path: <SRS0=NvMH=XE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E74C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 10:07:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0AA21D7B
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 10:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U2bHUHdC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRaSAzsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0AA21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=50DezHDUhMX892aXuWIV8ESD/j2s7Zq8tLYlYSRwCj4=; b=U2b
	HUHdCct5EDTTloRa7BG4AtsV2IENdxzoAEuhTqvyYPu4pqh2+FS4GvIydfS8IRNSboCF37Pa0Tz80
	xXjW32Z+HYqK3r0e9fE0l/Hzu0j4UlVrq9mx0Lgel/N85R9GOqayHfJwtNZibIuFCBEPtaf88oUdA
	sDcxf90ExGnsqk9repjQoc+wNKqs2iIY15IqUX6V+wXZMG7upchjFnErbqolYOhxk+Nw2tXGcWDGC
	Wm7/GDnR+7yA8nJW1RbD8bKi5hZwHAwQOiT4nndvY8X9qt8gaPRtOOMkJFxt4QskO823D3cmZFYGu
	gZQRkPaVehCSYClCalKZ8mePuT9Gurg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i7GZk-0000Gg-IW; Mon, 09 Sep 2019 10:07:12 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7GZh-0000G1-T6
 for linux-nvme@lists.infradead.org; Mon, 09 Sep 2019 10:07:11 +0000
Received: by mail-ed1-x52c.google.com with SMTP id c19so12359060edy.10
 for <linux-nvme@lists.infradead.org>; Mon, 09 Sep 2019 03:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=yF+S3f5L3R+X5oSnjKjqvnh/FJveZwN7QE+x+DbGsMw=;
 b=GRaSAzsjJqL+ErJzVxgW+UqsTbgRs0oN7aEir3UtYAHB/g2VyZFDswAp5xnYUuJ6mb
 929dRnIxSWg0F55w+s2/CH8zAtRjvOGx/vFQAoIVLY/8oJ3CCuI2Km6P4HRgr9V0JSMb
 eMqu+2E6Vb6xWdB76oMKZ4gKNRtC7Qtp/Ps3fniyZrpYBJemG6az6FhIxMp9/OAEEghy
 onZ5LuZPSDl0pOAxpRftGQ1+xNvGPnlsnGYMlATw5KE1tdKnzZ35kmHQLSeeHTUMS4LD
 CEfrJ33cso/MvkXcrmDIRVMg242uboXKX+i9yObntbucrlcK0HX/QkTcyHtWm7NWRzIq
 x/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=yF+S3f5L3R+X5oSnjKjqvnh/FJveZwN7QE+x+DbGsMw=;
 b=OKCyCLRIIa8r0w7NOpW0I1JgV/Ge1hUw3IuMhkwVyJpg8exVqTAh/nSX+CmFRkQlke
 M99VJbauVj0R7BUVASKVNXz0KMTjPgRds1mCkeyVySO2MIUOt1tGTO5xz3mh3EJlkE2C
 h5o0TyReqqbODbCRziUY5Z5dHzmzMQSIjGcleX0R4JGJvi1jhporWBEIR/Ha+bBWO5bw
 5ylhDJvFRaaMqHKmm/1s5TQyACP4G4l5LaChYjAfXwvvdGszjNqXW2cdE39w+t8SY0WZ
 XGyJGqz0Nfric9LTRJsdQ0A/cGNa8Ax22Rj5oAmD7NPupeyPyCeqVBy2C4PEG42+j7nl
 s8/Q==
X-Gm-Message-State: APjAAAUGmKFoIEpQz8q3FNUGP4355+BhDlN9KJrNsArMI4Hg/ZgYW4SG
 gzulIDPewBXpKlafZyn8FC5dOHq5Eq6DvTxTLGcPBPoaMf8=
X-Google-Smtp-Source: APXvYqw5f76fwxYwneIFoZaCLVKPQPbVRkdRiP74QKR7pMI20mqP5RsVXl89iZznq+jM/5TCtcok6/E+BGc5Pl/OR7w=
X-Received: by 2002:a05:6402:1426:: with SMTP id
 c6mr6950609edx.53.1568023627102; 
 Mon, 09 Sep 2019 03:07:07 -0700 (PDT)
MIME-Version: 1.0
From: Szymon Scharmach <szymon.scharmach@gmail.com>
Date: Mon, 9 Sep 2019 12:06:30 +0200
Message-ID: <CAKFbMv8u9w7jKB9tux1+4+8xQWdRpA4Y1kArrt6rCX1L0H76sA@mail.gmail.com>
Subject: "nvme disconnect" for mounted volumes - stuck thread
To: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190909_030709_959916_4F59B2CC 
X-CRM114-Status: UNSURE (   7.62  )
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

Hi,

In the deployment scenario i am using we use around 200 NvmeOF volumes
that are being connected to different initiators and after data have
been saved - reconnected to different ones.
nvme cli allows to disconnect volumes that are either mounted or
umount is in progress which leads threads to end up in uninterruptible
sleep. (D state)

root      69368  0.0  0.0   6704   640 ?        D    09:29   0:00 nvme
disconnect --nqn=pvc-4f6b7502-cb08-11e9-a2bf-3cfdfeb878d0
root      69375  0.0  0.0   5920   900 ?        D    09:29   0:00
umount /var/lib/origin/openshift.local.volumes/pods/4f6caee2-cb08-11e9-a2bf-3cfdfe-b878d0/
volumes/kubernetes.io~csi/pvc-4f6b7502-cb08-11e9-a2bf-3c

Those threads are stuck in D forever and whole block stack on the node
becomes unusable.
Is it the responsibility of nvme-cli or kernel module (nvme_fabrics
AFAIK) to block 'disconnect' in that case - or is it expected behavior
(nvme disconnect with force flag maybe) ?


BR\
Szymon Scharmach

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
