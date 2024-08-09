Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC764C52D7C
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Aug 2024 16:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pEJaYrwXC+MIdXum8Sq1+HJc5FpTLLeJvAgdeKuIRpI=; b=JRiR1bC1yMI4B1MdWmioCu0ZMO
	2XR+i97SQyWAxo3TN2vIOV7/iAVM4iTLfHIKvr2+PCpv6Ce33XKQOwqovVc/OMlCCLnkbRI5FRSgd
	JZe58oSx3LHh+pNnBl7mzOqzgtMWhleO1Au7FRFvN1t6d/pDBjkarImTNpQvl7DEELQu9q++6U4LV
	YFH7ywEWp3OV+pJ1lOukdS/jWPOxyS7yVYthL4++PCBcGeJ+4KVVISPB3RM/nSFaHkYanOywAZjfk
	yFhBp+wqFz7vI0a4f6NG3Vl64F9XYlA3hckbINIFCBYcyEj+jkIDM1ckO8o5lhehzRxoCFP0eeO2Y
	XGaRdoWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scSNY-0000000BtUe-2CyO;
	Fri, 09 Aug 2024 16:22:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scSJX-0000000BsIk-1fyD
	for linux-nvme@lists.infradead.org;
	Fri, 09 Aug 2024 16:18:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CC6F06165D;
	Fri,  9 Aug 2024 16:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642B9C32782;
	Fri,  9 Aug 2024 16:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723220282;
	bh=GqGl+RKVywsXDW0fCii8Qzvb9v/KFWWqqVmc+YgNwk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZvRnNIeYc/o06NZ862++AY+LZ1Q7OGcgLl7SayeVDA+xnOdfiPjxLjaPFWzMVv4RH
	 6hZUoIkWL5+t5pnAOGYK4ANZgTnwzdoQFIxtHv3f7NtbHxmPtYjS0Tx8lCMDLkLtLx
	 0ynB/WdfBmyuqDoGVZK9XxbfHTafu93iXyyXZzb6IlBN17wPi9qvCN2bnNMdSqpOQL
	 9CPEryiLMUsQ6BHEYzE4CSiirWnUsVKQcLtmPVLUYZU2kXILy0gsWfutM2EaUPGoyM
	 n83irxf0u45lbM4XMvjinXhI2R8FGCEZlBhCnZfw+rVt9VHxhZ6lkk+KiELD0XAwik
	 WZ4S9ORS8g9og==
Date: Fri, 9 Aug 2024 09:18:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: Dileep Sankhla <dileepsankhla.ds@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: Bug while creating the first i/o completion queue (NVMe over
 PCIe)
Message-ID: <ZrZBOMOSAgvd581z@kbusch-mbp>
References: <CAHxc4btbwU7z1AhYqUBzTeuULpRZbZpDj5Zodvr_p39FNPi44A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHxc4btbwU7z1AhYqUBzTeuULpRZbZpDj5Zodvr_p39FNPi44A@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240809_091803_506361_185FCC34 
X-CRM114-Status: UNSURE (   9.31  )
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

On Thu, Aug 08, 2024 at 06:55:14PM +0530, Dileep Sankhla wrote:
> Raam Raam sa _/\_,
> 
> can anyone immediately help me in solving this issue asap:
> https://github.com/robstat7/Raam/issues/4
>
> In the nvme driver, while creating the first i/o completion queue, it
> is failing with the status code 2 (Invalid Field in Command). The status
> code type is 1 (Command Specific Status).

You're reading the spec wrong. A SCT value of 1 with SC 2 means "Invalid
Queue Size".

And this is the Linux kernel nvme driver mailing list. This isn't the
right place to get help for whatever your driver is.

