Return-Path: <SRS0=neNW=HY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=BAYES_20,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,MONEY_FREEMAIL_REPTO,MONEY_NOHTML,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34222C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 15:17:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE566148E
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 15:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE566148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=real-ptt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Message-ID:Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Date:From:To:Subject:
	Content-Description:MIME-Version:Cc:Content-ID:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ucgexG9e0sUHN+Y2VcURf24owLghFoY3VMMgvXPNThU=; b=K+/L9zZoyPy3nc
	fFnex12FE2LMJydncKaAwW9drIMQTCKPg5w+A8cS00V3+Xm0YM8RW8mGUTLlD2zxJDUEhhMXlyWj3
	WzZa926JBdzERGG1HiqMfon1d/8/EDSAQGmH56Fm0ewhvVAwoJVHJgxXzV+FtiHfMLB1YsnNKCmCS
	/PnFnth45/d73n2gbSNOlL/T8qWXcs5FSZ6SJg2Ni3FXiu18dpmg0oXjuqiPz/wlIE8IfUtSBiTda
	DiXVa5M43LIixBM71HMtPLJvjbi005xUigmUVk53PnE0WRZe4I16eLO3mZX5cZcXk6np27iKpBT64
	PlBMDHKiUckDQ6CwZOVg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lECxD-0001gr-AE; Mon, 22 Feb 2021 15:16:55 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lECx7-0001dt-PI
 for linux-nvme@merlin.infradead.org; Mon, 22 Feb 2021 15:16:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Reply-To:Date:From:To:Subject:
 Content-Description:Content-Transfer-Encoding:MIME-Version:Content-Type:
 Sender:Message-ID:Cc:Content-ID:In-Reply-To:References;
 bh=pXIgOOxyZp4aE+IYJxOfc37kmQfJ+Fic1R3d+i9deOQ=; b=NVWSJOY8xBrsIOYaWXVRQNXxIa
 cGMt9PlewkMcaOh9zUvW545bQ0fbSiaBZJo2qW034AgwpRSqRxcoHWYRq6gJXtw9A6xJOjRG8fPAG
 hFgU/oy/1XvFHjCjEuF966NMqoEFgwuHYXlqrCPKy0g3+EKNExJuZHL0hjtP3JgjrJpo6GU8DOLNv
 W5gKE6r2oqPlKWSpyeutJc4tAz8ZhmlHj8tgUy5DEijv9b1QylNzNAMFMKAVTPMGx4zWAxN/+Zye5
 kJAKKigi6wj+sv1GJGwjq/hrgW6qhvYebTb10BASLHgcHus0lvFDCgtSIcUes0z/evabl1qnsxaQ9
 grmFs5eg==;
Received: from [8.211.43.121] (helo=mail.real-ptt.net)
 by casper.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lECwv-006jB7-W1
 for linux-nvme@lists.infradead.org; Mon, 22 Feb 2021 15:16:42 +0000
Received: from [103.99.1.174] (unknown [103.99.1.174])
 by mail.real-ptt.net (Postfix) with ESMTPA id 6FFB7BBE8C
 for <linux-nvme@lists.infradead.org>; Mon, 22 Feb 2021 23:16:34 +0800 (CST)
MIME-Version: 1.0
Content-Description: Mail message body
Subject: Low-Cost Loans for SMEs & Investment Funding.
To: linux-nvme@lists.infradead.org
From: "Nicholas Toms" <service@real-ptt.net>
Date: Mon, 22 Feb 2021 07:16:32 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210222_151642_167580_28C81274 
X-CRM114-Status: UNSURE (  -3.58  )
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
Reply-To: nchlstoms@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Message-ID: <E1lECxD-0001gr-AE@merlin.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

My name is Nicholas Toms, an investment portfolio manage. We offer the right loan Investment funding with low interest to finance your business or project ranging from US$1M to US$2BIllion. Kindly contact me for more details as I am open to questions. 

Sincerely, 
Nicholas Toms

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
