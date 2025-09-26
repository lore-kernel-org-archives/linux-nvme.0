Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B4BCAC5B5
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Sep 2025 00:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jjbGdBwq2006vqwICfHyxoDraFyxDybXnS62qQy3JtA=; b=GtYiCHnafHtSjEQhms09/uq9PK
	srPR/qwzUuXAdppNvtLwsXElpT0+ftsr4GkyOYPIGK00Exl7gAwywjP2iDagZMndQbcaVNtpIR+S1
	xVqM9KtCcOLWhONhLRLk4rznX/smFmS7iNCRcUFCzNoXaaRjrG/mR4ZPIzHrT8+XxRxvIw57dE5IC
	C0/Lo7X400OU8BqsB++9AKwJt3MfrbDO0vJCDvJHlFTBoKGP2GHZx3LaYeitrhAI3ypzF0oTEiezL
	UTBgDvwOi3A5wg+vk18/f29XvkWDnAxeEa6n9d+tlgCzMF2/GamlJQkKO0eiZtM0eK5xFq2xyAldV
	UYJ4pBBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1wab-0000000ERbE-2mob;
	Fri, 26 Sep 2025 00:45:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1waY-0000000ERZJ-3H2n
	for linux-nvme@lists.infradead.org;
	Fri, 26 Sep 2025 00:45:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758847529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jjbGdBwq2006vqwICfHyxoDraFyxDybXnS62qQy3JtA=;
	b=hlY4PUncYCbGij9BeeXW0/yc+aip8sTwV7RXVNfzyrUMLlkIy6qI1HpUoUXBl4HOUtewdl
	nFKeHttmvwpjxueaAaxeUilqUDS3Xl0Ab3X3a4uzX46I2dYEUgCN6ScWPukvfsk6r770tA
	39cfQTRpHgxaHHPHm2M2oeOMqQS16ko=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-scvIZ2_lOIqIKkiWdzGQHw-1; Thu,
 25 Sep 2025 20:45:26 -0400
X-MC-Unique: scvIZ2_lOIqIKkiWdzGQHw-1
X-Mimecast-MFC-AGG-ID: scvIZ2_lOIqIKkiWdzGQHw_1758847525
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18CEF1800578;
	Fri, 26 Sep 2025 00:45:25 +0000 (UTC)
Received: from [10.22.81.200] (unknown [10.22.81.200])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76C671800451;
	Fri, 26 Sep 2025 00:45:24 +0000 (UTC)
Message-ID: <33df2147-83b5-420d-9879-acdd1c5a8e3c@redhat.com>
Date: Thu, 25 Sep 2025 20:45:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: John Meneghini <jmeneghi@redhat.com>
Subject: ALPSS 2025 nvme-fc: FPIN link integrity handling
Organization: RHEL Core Storge Team
Cc: Howard Johnson <howard.johnson@broadcom.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q3s2KGMg9gloXjDWkAhlJrt-NIfnHgCrOUSYmTZ4QRI_1758847525
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_174530_888905_FAE2D240 
X-CRM114-Status: UNSURE (   4.57  )
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

At the ALPSS conference next week I will be presenting on the topic of nvme-fc: FPIN link integrity handling.

https://www.alpss.at/#schedule

During my talk I plan to give an overview of the recent changes this patch set has under gone together with a live demonstration of
FPIN LI working with nvme-multipath on the test bed in my lab.

The latest patches can be seen at:

https://lore.kernel.org/linux-nvme/20250926000200.837025-1-jmeneghi@redhat.com/

A copy of my presentation can be seen at:

https://github.com/johnmeneghini/linux/blob/fpin_v17/fpin_li_readme.md

-- 
John A. Meneghini
Senior Principal Platform Storage Engineer
RHEL SST - Platform Storage Group
jmeneghi@redhat.com


