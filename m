Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF005C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 17:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:From:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4xTW3tfQpjY/eziWf0fRa5/5pUTc2a0EedcDcc0EMHI=; b=Spkc9WH3c+TU0Qjn6+IVWX4UrY
	WUIbr7ih9SY16yt5DTIsa1o+7+kAaYhmiy6WkxgOOqwXo0YoWda8I3Dsfz4x27ar2rGFu8l4wP/KR
	0TIaN2jbzvsC4h3416YMePsaCsrQ5WYue5wUhXw6aq67j22HWcXYPfkiJgoMYwY43aJEzkVj0l4Av
	vzhezNSuSOFARlZsXMdgOL4+6QExc7F2bK+MJmkh4pKaTFwIbnypMxCLAxCPUnKU+VWap7dD7n4tD
	TOoshqlPqwre0kdeUmZxlV9+Lg4kU9ZVpjzbyzifTAbukij+pCvV82I7xUci/uhCbXPcoeEsUgMNt
	IIzEYYKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8mA5-001mLc-PH; Tue, 05 Jul 2022 17:16:33 +0000
Received: from mail.ugholf.net ([209.181.64.171])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8m9g-001lrH-RS
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 17:16:10 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.ugholf.net (Postfix) with ESMTP id 2CE5C1626B3A
	for <linux-nvme@lists.infradead.org>; Tue,  5 Jul 2022 17:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugholf.net; s=mail;
	t=1657040930; bh=4xTW3tfQpjY/eziWf0fRa5/5pUTc2a0EedcDcc0EMHI=;
	h=Date:From:Subject:To;
	b=E7KHsGR8vZaJQu3KXntKrbllM7R9C5Jke+nqbJrXVzYYoBL4pTT74siTP+nyiTHNA
	 v4ZNLhn9sDVQ9rI3O5/0AT1ouKExtP6UBQ5G9DFBXVnlvH/7fb0l8azXHfuC5XSOjQ
	 O3qnFsaDAl73oKn5twrl4UNksbB5ai3w7pdfl01Q=
X-Virus-Scanned: amavisd-new at ugholf.net
Received: from mail.ugholf.net ([127.0.0.1])
	by localhost (kenny.ugholf.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K16x6fijoFqi for <linux-nvme@lists.infradead.org>;
	Tue,  5 Jul 2022 11:08:45 -0600 (MDT)
Received: from [10.1.32.33] (pool.transmontaigne.com [38.109.195.110])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ugholf.net (Postfix) with ESMTPSA id 5136A1626B2D
	for <linux-nvme@lists.infradead.org>; Tue,  5 Jul 2022 11:08:45 -0600 (MDT)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.ugholf.net 5136A1626B2D
Authentication-Results: mail.ugholf.net; dmarc=none (p=none dis=none) header.from=ugholf.net
Authentication-Results: mail.ugholf.net; spf=none smtp.mailfrom=ugholf.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugholf.net; s=mail;
	t=1657040925; bh=4xTW3tfQpjY/eziWf0fRa5/5pUTc2a0EedcDcc0EMHI=;
	h=Date:From:Subject:To;
	b=Ur5xi1+KZNYruST/fFCsGhejqZOqNK/LYr7W1vLN3hge5MqPve8aJWLO19ErswTup
	 cOxMglFRYStVwK7luA0c3scQh6rHzVEoc4oj5NK0Cc9SLNWplS7XUG7M1anQ6uk9Md
	 r8g1tVfWCxuvnkShK2cwQfCN1e8HAu6dtkMIVz7s=
Message-ID: <e1005e65-95d0-7ed0-fa41-85a2a2fb6876@ugholf.net>
Date: Tue, 5 Jul 2022 11:08:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From: Chris Egolf <cegolf@ugholf.net>
Subject: Phison E16 Bogus NID quirk 1987:
To: linux-nvme@lists.infradead.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_101609_091291_F4A21F83 
X-CRM114-Status: UNSURE (   6.74  )
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

After upgrading to the 5.18 kernels on Fedora 36, a second identical 
drive is not visible and I'm getting following dmesg errors:


"nvme nvme1: globally duplicate IDs for nsid 1"

The drives are:

Vendor:    Phison Electronics Corporation [1987]
Device:    E16 PCIe4 NVMe Controller [5016]
Subsystem: Phison Electronics Corporation E16 PCIe4 NVMe Controller 
[1987:5016]


I applied the patch from "loqs" in the Arch Linux forum (link below) to 
a fresh 5.18.9 kernel and the problem was fixed for me.


Relevant bugzilla and Arch Linux links:
https://bugzilla.kernel.org/show_bug.cgi?id=216049
https://bugs.archlinux.org/task/74916



