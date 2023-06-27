Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C44EB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jun 2023 16:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9A6ATY9LqaJSfWJfx2WWx323Pvwd+t487KhiuT9/AfA=; b=3qbCbHADtWoaOVOS1aLIaJ1gNq
	Yt0cMYXcr1Bh8x+TEMT+cF3fL8y30hFQmSWRXpzhH5Gc7nEgkaZVBHUzEFkCSrp4aRjRUXocd4lsR
	gtAwJgqTbfIaPr0u9N2UHODmTqQwHYXS3U4PgM6yYSw9cDwLG5SF3FM2bN0yNvc/UmizyL1utNFtW
	qZTQNoElplmlmOG/tzp3WwTGzNb3uq8zBcJBjHvdGGDnXYJu7MOGp477+8MTlHWi3/XcunrVpfZG9
	2FlBiXejCzvJk7cfrmwSWePg5cCSx4ObCzRN9Ly4c9/WeprcgocJsul++h4j5+S+lMXxiW6Xpk4NQ
	d4Folgfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEBdZ-00DeGr-37;
	Tue, 27 Jun 2023 16:33:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEBdX-00DeGQ-1L
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jun 2023 16:33:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687883629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9A6ATY9LqaJSfWJfx2WWx323Pvwd+t487KhiuT9/AfA=;
	b=MwQFzVg52ETVJrKKmnqOTYif5Ual9+c6u1xLxK3q0BINj8veDKOgAnsFWCgkgxYBfasv2Y
	p2qLN4pVCyu4pAulXPW4RY7PjAKiHgEXH2uPli/ChKFwv8Hs3FjzsFQpDq9EL4+RGKlXRA
	SNe7p04bApdKatnZ4Zm6MYLK3TLAadk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-bSE-kWY1NQusRrW7KAzJsQ-1; Tue, 27 Jun 2023 12:33:47 -0400
X-MC-Unique: bSE-kWY1NQusRrW7KAzJsQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b82bf26542so2225495ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 27 Jun 2023 09:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883626; x=1690475626;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9A6ATY9LqaJSfWJfx2WWx323Pvwd+t487KhiuT9/AfA=;
        b=CFEjfPwZEcKcaCd+3V40sU6I2mRgapdSY5AA3HbHfMa+el4bUqAWzcOYAxsSNqSxgb
         lWvLDcemJgQA8Ty49J4Q0wcOZ+WZufziG6qD7eD8h4htm4+pTPETSmIVSt4sue+4EG7m
         3PzKFCZj/cv9BHQE+YZoMYSvkwXkDqq5Uz3u6oFnWZy/VlNU1fsH2/eTKOKj5+EpxtGE
         xIEMimA++q039NNDnx3xtJH0yVV176rd2g8nQkVNwwxvW4U16P6yy9re51V9biFow5mF
         pTzJvaklADxvt0kLKZkXKUoS9b9KEXc1mclPEsT9ErTAHtwAdS5AXtvw1wQjWjg5GJLi
         lBgQ==
X-Gm-Message-State: AC+VfDwb0HQDTQtHDANIr/2GszsNvOAKEyFp25zavYAnSKp/B3pQr9h9
	vxp21vrMcyj46P289J+ic8ZFivATynNk+1rb/a9J8LIIevM+0ORw/tJ5fbra3x9wxhEQ/AiRE/9
	hPi7Llga/e/MO3bdzLf0navc9+BQTxWVq7OohQtq1ODaDa3aKgvDJhvRk
X-Received: by 2002:a17:902:e811:b0:1b6:80f0:d97a with SMTP id u17-20020a170902e81100b001b680f0d97amr7578766plg.19.1687883626149;
        Tue, 27 Jun 2023 09:33:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7fxdyZwD/T9HTf1SSNThYAa5VjotAfp4yLFOUFO6NZozSLACNYaRtimkegV2xAvHR+lRGiKcc3Uwp9cyBJgxs=
X-Received: by 2002:a17:902:e811:b0:1b6:80f0:d97a with SMTP id
 u17-20020a170902e81100b001b680f0d97amr7578754plg.19.1687883625837; Tue, 27
 Jun 2023 09:33:45 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 28 Jun 2023 00:33:34 +0800
Message-ID: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
Subject: [bug report] most of blktests nvme/ failed on the latest linux tree
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_093351_545088_C183A291 
X-CRM114-Status: UNSURE (   8.26  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello

I found this failure on the latest linux tree, and it cannot be
reproduced on v6.4,
it should be one regression recently merged to linux tree after v6.4.
I check the commit recently merged after v6.4, and found below commit
touched the related code, not sure if it was introduced by this
commit.

commit 959ffef13bac792e4e2e3321d6e2bd2b00c0f5f9
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Thu Jun 1 23:47:42 2023 -0700

    nvme-fabrics: open code __nvmf_host_find()

[  524.706158] run blktests nvme/004 at 2023-06-27 02:00:43
[  524.779499] loop0: detected capacity change from 0 to 2097152
[  524.790075] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  524.810743] nvme_fabrics: found same hostid
08dfb4e9-d246-4450-afb6-bc6249f9dc96 but different hostnqn
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-005a-3010-804b-b4c04f4e3232
[  525.346603] run blktests nvme/006 at 2023-06-27 02:00:44
[  525.380421] loop0: detected capacity change from 0 to 2097152
[  525.391846] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  525.901516] run blktests nvme/007 at 2023-06-27 02:00:45
[  525.934980] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  526.412792] run blktests nvme/008 at 2023-06-27 02:00:45
[  526.446070] loop0: detected capacity change from 0 to 2097152
[  526.456790] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  526.471220] nvme_fabrics: found same hostid
1cb04df4-a83c-4257-84ad-aa5dab3e961c but different hostnqn
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-005a-3010-804b-b4c04f4e3232
[  527.014108] run blktests nvme/009 at 2023-06-27 02:00:46
[  527.045095] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  527.059680] nvme_fabrics: found same hostid
1584c36e-4a26-4408-a7d6-5608c0197141 but different hostnqn
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-005a-3010-804b-b4c04f4e3232


-- 
Best Regards,
  Yi Zhang


