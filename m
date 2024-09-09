Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4A7ECE577
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2024 00:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=Ls8MQytueCr7wfTYq74TgdEPXQ
	j18tTBGFEs7JFET1Sc/MUnv7TsimHhRO4A/YyeOcNlLdhAsnakndKEZbxo+tICfUhmIVr0IwqYsoL
	BtY2g6EIv9s6HgesRaN5LlVFn1HdSRSDMN0IgkBeGg2ve1JajRccryYsGuJBDFgt4F727rWUo5LNp
	NgfT/I6jylOQp4t1UwPhIiymTUghoP4TRg5JbeQwwIToUuNikD9gyxD1xXgKG6Z8bj7mSDaP4OAhz
	OZUCpe2WxRzsTl0yN1rWF7tdCJDP/LlUwNjClA0VF/PpEQVavL/7ifrOm4becVfMsTNR4+tBvXkAR
	yf1EueEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snRz5-000000005kC-0rY8;
	Mon, 09 Sep 2024 00:10:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snRz2-000000005k0-3Rxk
	for linux-nvme@bombadil.infradead.org;
	Mon, 09 Sep 2024 00:10:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=NQ2r9rIW9HYbS2qdgqE6bkEdsH
	bOyduLlorRi3bsZFke1kFkMvmzNYfWPmOtBJB17fCulRLKs4mjQSdTmtzcPAkt1xuHLY4ink2Vnk0
	ZmjAoYE7QX0lX5UMMI1l+EuFuMEopjo8B1Z9o6UgYW2f3JufKW0M7UJlolPldix9Cc6a6UQLv3JAZ
	R2R3zrmdMEXHbo5WQfPAwl1VkfLQup0gGMWzQhbITQE3V1EQcgw8BJwFJAQ1fLaXHkRrMXHPUc8s9
	84vo3tlZa1Ct+4Z4z/+T7HwI1vUlw8JWPNtfvwmn8LdxZrtwgLl2Wdf8IoN0fDqRGAdjitvWbn/ss
	1z32VxwQ==;
Received: from 89-138-71-253.bb.netvision.net.il ([89.138.71.253] helo=[10.100.102.67])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1snRyw-00000000HvP-1i6t;
	Mon, 09 Sep 2024 00:10:17 +0000
Message-ID: <933a7f5c-6d42-491b-be84-7dc10689cc3d@grimberg.me>
Date: Mon, 9 Sep 2024 03:10:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: sagi.grimberg@gmail.com
From: Sagi Grimberg <sagi@grimberg.me>
Subject: test [IGNORE ME]
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



