Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326F2C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RfKhb6rf3Jwn3+0DG//0+koynavdCDyxgQQkmGThFEM=; b=vgb71I2G9nGcwc0U5LXs/Eo78C
	d+tJwrPAUXsmoduAfzfBu0XhzZahZJPimM98Ze3FkHlGC3DkBpIFkKWA5kfICEtTxGesvqLelSJ6S
	04e15rsjV2CY4wonBGkHy5KQTGrg2pfaT0Nbq/p8D6CdJZ99SuXMGbftmVofND0rgfiTBcaVml3qA
	XSSy9sO269ikQLNWzlixdrRcAjZlXrFqHBPusaIaIuDVaKeVZxBFq8Ntsu8OQnYH+dHvNJPbemOtJ
	EYQwO7PSa4qVJdIPh8kYAoedJRsLArT8aTNhn0yXyZeUD0TnEjCxpZo5OSGJAeeDqSHKgFubJgP66
	yuyYThpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqFt7-00BpLt-0u; Wed, 02 Nov 2022 15:42:45 +0000
Received: from odysseus.binarus.de ([144.76.90.229])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqFt4-00BpJv-13
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 15:42:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=binarus.de; s=b201601;
	t=1667403742; bh=m5OZdRWjMiGtcX+eCTxgh6nhgu02xZ4UObKR21PIZ9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Reply-To:
	 Subject:Date:To:Cc:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	 List-Subscribe:List-Post:List-Owner:List-Archive;
	b=B3TynCSzq9PmDf/4ay4ZIwU63y1aVg2L2lC3SqOOUe06ahmIy6vEqiSzrSSUtxjRX
	 mDMuH3zogfqV1B69rIZ+O1HCp086zUQk99aH4356qZr4X08P6vJx7CbtCuoLe9z5GT
	 l1pUfqaB1oHnM7STZ5MpudZSIPjT1w4YGqC0s4RFfgQ9dUlxROKK+Nxip+ctOxckh/
	 xH/6+em6cSbQV4aVU/zo2REhBrHw+ppMOBv2KMIr7HpHt/eR9CvsyFZppVaWu2e1r2
	 wuXCUX/jZ2euP8VdaaUbFaAJigisfridbHg3QfRSGrsEOrFSQJg+j+2dnyhEALvzsF
	 1MFYSwFz4JGTmipzvGREEUAIcuyhu/C8BzeYzo5Tn0HS7eSD3G4uLvABGkNvvBsc7J
	 ILYW6K05ggYu/oTAhsf8p0DiX1fPkiHiOqM2OYXntM9G1nV7IdBh2eFxcV743I5HTl
	 eiE1CwZVXIpodvgSOblNm0JuPp5O3u2wvt79mK7OvPXOBrv2Ani6fRCAFXYXPRnRfS
	 3pX2pbgbjGRVwBhvcqw8TuEiqsYTii6GI9S8ljBPrNEq/ldnqJO9v+aJUtkF3XHODR
	 W5rtaCdIRdMUj4B08ye71d5/sup5pO0UZNlEgylcrmuanv3V26tHRyCmMvAzhyAx0Z
	 nYaO0Nx2ePce09XK0BXgxlN8=
Received: from [192.168.20.100] (pd9fb9b07.dip0.t-ipconnect.de [217.251.155.7])
	(authenticated bits=0)
	by odysseus.binarus.de (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTPSA id 2A2FgLnD020686
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Wed, 2 Nov 2022 16:42:22 +0100
Message-ID: <0865c0c4-1632-3a86-939b-feb2d2ce7f32@binarus.de>
Date: Wed, 2 Nov 2022 16:42:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Betterbird/102.3.1
Subject: Re: nvme-format: protection information enabled although metadata
 size is 0
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <b9ca7931-0384-d0e1-92b5-c2ffbadc195f@binarus.de>
 <Y2KN8wHy5l9HxOgW@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US, de-DE
From: Binarus <lists@binarus.de>
In-Reply-To: <Y2KN8wHy5l9HxOgW@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bin-MAIL-FROM: <lists@binarus.de>
X-Bin-RCPT-TO: <kbusch@kernel.org>
 <linux-nvme@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_084242_767838_87BF7633 
X-CRM114-Status: GOOD (  12.98  )
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

On 02.11.2022 16:34, Keith Busch wrote:
> On Mon, Oct 31, 2022 at 10:27:34AM +0100, Binarus wrote:
>> On a machine with Debian Bullseye and nvme-cli 1.12, I have formatted an
>> Intel DC P3700 the following way:
>>
>>    nvme format /dev/nvme0 -l 3 -i 1 -f
> 
> You correctly surmised that the device is behaving out-of-compliance
> with the specification. The device should have returned an "Invalid
> Format" error since, as you found, this is the error to return when
> "enabling protection information when there are not sufficient metadata
> resources".
> 
> You're unlikely to find a fix for this EOL device, though. It's just a
> firmware bug that you should avoid.

Thank you very much for confirming that this is a bug. May I steal your time again and ask what you would do in that situation? Throw away the device because we can't trust it, or format it with 8 bytes of metadata and hope that the PI works correctly then?

In every case, I have seen in the meantime that the firmware on the device is hopelessly outdated. At first, I'll try to upgrade it. If that works, I'll repeat the test and report back.

Thanks again, and best regards,

Binarus


