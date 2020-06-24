Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251CBC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 09:48:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7B22088E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 09:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xBTjsuxS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="mFt6k++W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7B22088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:To:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cRvUaS0CjdyNnaaBrAJkdNlizozDxz0qWGAHPoV0yJw=; b=xBTjsuxSIpLlXC
	HxnIr7/SaeLb7VonZWQT6REFs4dvYAexCltZnPyEMWKF1nHF/Lk0JyF58EZ6N+KF4f35HBKWQI10s
	X01SB8KFV9pHkXwb5rHH/0holQcNamCSqAhYhDbCGgJBbz3b0BDpn9EKN7/ShKdjb83ujoqtoLD6D
	4MQgZvcFSE0Z1A/OacbKbwb/Wu6hpxsxML4uYKR/Vta4W0hbs3RkaMLBZpheJXpM1bBOtWmZTtEbB
	BqLpj8odF4QSNU4MhOLI8Fr5z12a5J5jYSMgvW04HUEL5q0yNeC8tTtXu8TYwxvSNmB7MeuSPWSpp
	zx5V/oFd+mJaxZH1r16A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo21C-0005Hc-NF; Wed, 24 Jun 2020 09:48:34 +0000
Received: from forward104p.mail.yandex.net ([2a02:6b8:0:1472:2741:0:8b7:107])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo213-0005Ed-Gi
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 09:48:27 +0000
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net
 [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
 by forward104p.mail.yandex.net (Yandex) with ESMTP id AD0544B013D9
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 12:48:18 +0300 (MSK)
Received: from mxback12q.mail.yandex.net (mxback12q.mail.yandex.net
 [IPv6:2a02:6b8:c0e:1b3:0:640:3818:d096])
 by forward101q.mail.yandex.net (Yandex) with ESMTP id A9A7BCF40004
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 12:48:18 +0300 (MSK)
Received: from vla1-422e55233c16.qloud-c.yandex.net
 (vla1-422e55233c16.qloud-c.yandex.net [2a02:6b8:c0d:1a17:0:640:422e:5523])
 by mxback12q.mail.yandex.net (mxback/Yandex) with ESMTP id FFqoGW2Mg5-mILixXBC;
 Wed, 24 Jun 2020 12:48:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1592992098; bh=uk6E/7R/0b66W4CozfYYpUV0rrHYVWgQhGr3i5L9nBY=;
 h=Subject:From:To:Date:Message-ID;
 b=mFt6k++WtWu44JAPn5KgglWCgyd31K+5ryfWCfS8GU8b2qWQVtRfCidEHgh5nbaoU
 NNX8PZBbRphIIgVW/vV7ZDM3vFKOAdryMLfpWJV/ur+GpkOnrMjpkVN7g9CCJkAFfO
 03DmwUz+pOv+zzKVEcr79euWaJmuT16Kw/tZldOE=
Authentication-Results: mxback12q.mail.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by vla1-422e55233c16.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id V1wi0BCxn7-mIlGITw6; Wed, 24 Jun 2020 12:48:18 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
To: linux-nvme@lists.infradead.org
From: Alex Talker <alextalker@yandex.ru>
Subject: NVMe over Fabrics transport requirements support
Message-ID: <eaceb06a-79d3-2b97-c975-6f2f641e90c7@yandex.ru>
Date: Wed, 24 Jun 2020 12:48:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Is it true that setting any value in addr_treq attribute of port in via 
configfs

only affects displaying TREQ on discovery page and doesn't anyhow inflicts

"whether connections shall be made over a fabric secure channel"?


I can't find much about whether RDMA(RoCE in particular) is secure

but for TCP TLS is must-do these days I think.


Is this functionality planned to be implemented in near future?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
