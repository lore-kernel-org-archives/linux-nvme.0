Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3ADD597C0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 00:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nhknlDy3IxbjPETAYjBXz7ygbOLv/KI1RPn4fkMI82U=; b=t9poXdKieYG3G/E8OWFp1g9TsH
	MSWfYva9j9aj1sDRxJf113/S/X/Y1If5FnljCyvE5bzTcIokPVwJgBHJf2tl6Z6iybW/Qik79EFTK
	ApqYcHI/xdiseBE7P+VssTv4JP/nuRWjBmxqf1U0UHrBhBdp8sCSHnp7d+9uHfbvVpLcVeE7aUCzp
	AkpLxJMyXB+O0yVKzMOOPjN8wt43aGEq1sMwgiFNT3TZoLDxLK5hi0L5no2lyqMd3aH6MUexO5meJ
	yx+5bNBAciq4KNE4100dvY1oig28Qoq9IbIkzhATLicT2BSB+lagFr+/srb1ATM/JdzZBYQbh3cLS
	UKvZPkPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tB1Bz-00000005Olq-0OaR;
	Wed, 13 Nov 2024 00:25:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tB1Bu-00000005OkW-3jMH
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 00:25:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731457501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nhknlDy3IxbjPETAYjBXz7ygbOLv/KI1RPn4fkMI82U=;
	b=Xz0EJOi+e9BUk3aXAqN2mXuE+XiywSywBncfZxeQzWPP457w1loLP3YaWNmI0O+lpsr8gD
	RCZSynpon/VMcLEm+b+YH3RwRjLWYStY3jmO0LGxFNDqZYqiLpgcvZX9mNzqUcLnRYmbwr
	YbCuyaWm1Fw06vrnxeJd3ePXMMO4ZZ0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-3S8SYUAoNjaE9rIqXpUlwQ-1; Tue,
 12 Nov 2024 19:23:09 -0500
X-MC-Unique: 3S8SYUAoNjaE9rIqXpUlwQ-1
X-Mimecast-MFC-AGG-ID: 3S8SYUAoNjaE9rIqXpUlwQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F21E19560B0
	for <linux-nvme@lists.infradead.org>; Wed, 13 Nov 2024 00:23:08 +0000 (UTC)
Received: from [10.22.81.39] (unknown [10.22.81.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BD2530000DF;
	Wed, 13 Nov 2024 00:23:06 +0000 (UTC)
Message-ID: <889e1d2a-1cda-4979-8279-f2f665350376@redhat.com>
Date: Tue, 12 Nov 2024 19:23:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: John Meneghini <jmeneghi@redhat.com>
Subject: CONFIG_NVME_MULTIPATH - Do we need this?
Organization: RHEL Core Storge Team
Cc: Ewan Milne <emilne@redhat.com>, Bryan Gurney <bgurney@redhat.com>,
 Chris Leech <cleech@redhat.com>, Maurizio Lombardi <mlombard@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oaJUSPCAg5H7ZLC6K6T7-wKMhXmhJst7hB1hTUrtVjo_1731457388
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_162503_046997_A105ECE2 
X-CRM114-Status: UNSURE (   7.86  )
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

Now that RHEL-10 beta has shipped we no longer support anything but native nvme multi-pathing and I'd like to do something about 
the multipath module parameter:

bool multipath = true;
module_param(multipath, bool, 0444);
MODULE_PARM_DESC(multipath,
         "turn on native support for multiple controllers per subsystem");

I'd like to remove this parameter from nvme_core/multipath.c. The fact is, setting nvme_core.multipath=N never worked in 
anything but RHEL and keeping it around only causes confusion.

For that matter, I'd like to remove the CONFIG_NVME_MULTIPATH kconfig option altogether.

Does anybody actually use this?

# CONFIG_NVME_MULTIPATH is not set

Do we actually support running nvme without multipath.c ?

-- 
John A. Meneghini
Senior Principal Platform Storage Engineer
RHEL SST - Platform Storage Group
jmeneghi@redhat.com


