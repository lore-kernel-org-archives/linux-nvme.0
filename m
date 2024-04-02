Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663BCC6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 15:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VTZDTry4iLRYYk7znZMyIwOmtb4mpRhpVQzIYKZgUBM=; b=1G4h0m2YMc04WUS5dmzxA2CZlU
	Tb1EDMMK2qNVupJ4OEqD14Rxx9NPfUts6+XmP6oLsdDdEuoG2Km6VpsiX0mmfnv584JO+2XSDFrUC
	Vf5euESqBAasCZ3+fF0SkJUjncpBlYIT4kZdPfKOvNP9rTPt9lnNXdEvhp/tqn4d358oqmzj1WAwZ
	LVLtAfwh904gEIT7Wtb0K6cjwTH14efSrBj/APwfDMhzAo7udEayoMSPVt0TI2GJWBVgL7FO1H8oZ
	+Gi128MrEF4VQVD5Q8URvPoPBRtbYZSK7sq7mQKngaFUPPWnCCwoFf2bao86lWBrOyMTF9oqUdvT6
	XkgZjQvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrfpp-0000000BldQ-0UUo;
	Tue, 02 Apr 2024 15:14:01 +0000
Received: from mail.tuxedocomputers.com ([157.90.84.7])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrfpl-0000000BlaU-0UHI
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 15:13:59 +0000
Received: from [192.168.175.29] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 55A6F2FC0052;
	Tue,  2 Apr 2024 17:13:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1712070829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTZDTry4iLRYYk7znZMyIwOmtb4mpRhpVQzIYKZgUBM=;
	b=Kj2In7m7Cv9V3hoWpJUxThUI0AEr+NmsjEaGwl/dI+e3fkN6KMCa4TLYXPD9IawmNsWrnO
	QoM72gDZkYsEyfcDvgeOHzeHEzH+6sGgQx6oIjGFzDU6QXljCkyZ4Ge5r3Ff07lVNrMz3Y
	N5e8YBUAmUZhvvuw+ax5yK4HORBLh18=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=g.gottleuber@tuxedocomputers.com
Message-ID: <230e3f41-9f6b-42fd-a411-567abbaebbbe@tuxedocomputers.com>
Date: Tue, 2 Apr 2024 17:13:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Samsung 990 Evo
To: Christoph Hellwig <hch@lst.de>, Werner Sembach <wse@tuxedocomputers.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Georg Gottleuber
 <ggo@tuxedocomputers.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240328130923.61752-1-wse@tuxedocomputers.com>
 <20240402131658.GA31963@lst.de>
Content-Language: en-US
From: Georg Gottleuber <g.gottleuber@tuxedocomputers.com>
In-Reply-To: <20240402131658.GA31963@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_081357_793476_34A818A5 
X-CRM114-Status: GOOD (  11.48  )
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

Am 02.04.24 um 15:16 schrieb Christoph Hellwig:
> On Thu, Mar 28, 2024 at 02:09:22PM +0100, Werner Sembach wrote:
>> From: Georg Gottleuber <ggo@tuxedocomputers.com>
>>
>> On some TUXEDO platforms, a Samsung 990 Evo NVMe leads to a high
>> power consumption in s2idle sleep (2-3 watts).
>>
>> This patch applies 'Force No Simple Suspend' quirk to achieve a
>> sleep with a lower power consumption, typically around 0.5 watts.
> 
> Does this only apply to a specific SSD or all SSDs on this platform?
> How do these platforms even get into the conditional?  Probably
> through acpi_storage_d3 setting, which probably is set incorrectly
> for the platform?  Any chance to just fix that?

Yes, this only apply to a specific SSD. I tested these SSDs (on 
PH4PRX1_PH6PRX1):
* Kingston NV1, SNVS250G
* Samsung 980, MZ-V8V500
* Samsung 970 Evo, S46DNX0K900454D
* Samsung 980 Pro, S69ENX0T709932L

S2idle consumes around 0.4 watts with these SSDs. But with a Samsung 990 
Evo s2idle on this platform consumes 3.7 to 4.4 watts (6.8 vs 6.5 kernel).

With my quirk s2idle sleep consumption is at the same level of all other 
SSDs tested.

Other boards have different values (a bit less drastic: factor 3 to 8).

All measurements were taken with the battery disconnected and a
modified adapter plug.

Because of the isolated problems with this SSD I have not debugged 
acpi_storage_d3. Do you think that would make sense?

Kind regards,
Georg Gottleuber

