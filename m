Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E41CF2590
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 06:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1bqHkn/Ok4thGi5wUFLcdt14p2wNx04jrYW8gMrHveI=; b=BDPG5aAYM4ccIs1nOUgqqxHwcK
	6wAAMcAdAnpgYdFJ8KK29V1M9LgIF501Kl6CdoUD4olqnaYJopTGcU6gzUk4DVq4JiuzxuDG4CMV/
	Cv7W05P//qy9Uw9vLfrrCAPRgggf0Na/qBtaggbMGfxrkWWIswCfY0vFlu/UWdR9Rdzk87Ffmd7j9
	Kg7SispYmtPdA70zWLkdWsnKXWoNDI+pq9PCCIIAsPu+i06/HXfueFJ77zcqRRpBC2lOqXch413xN
	TRv2I0t3rttD6XLSnpe6ugZx5q3Xhd/RcbLQ1aRX1yi5Cvruttm6xuqPmet8nxkIFjejarzScIoYX
	2RKn6qWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0F1Y-00000003xvs-1dUo;
	Mon, 14 Oct 2024 06:57:48 +0000
Received: from mout.kundenserver.de ([217.72.192.73])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0EzN-00000003xbl-0z0F
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 06:55:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=open-e.com;
	s=s1-ionos; t=1728888928; x=1729493728;
	i=artur.piechocki@open-e.com;
	bh=1bqHkn/Ok4thGi5wUFLcdt14p2wNx04jrYW8gMrHveI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=n3T+LVOgb8UmUXt6xHenmlnBOIhNfiemfn3KnjZUSPUd4bq8ecaJrLfLyWIMW/kU
	 IBbKtVUnZAq403C91xlPFLVeQJAcQjYw99nj+u7ewjRiFhFdy1znxZyERZHWk0dLA
	 4K0zdZQjYQ7Y0G5AlTeVDMQgEOboFVe/VzUH7JRhyAAk1lvHpQR2BHXYl6At2fjFm
	 aUpkXKsXEHsN0tS2XIYfqwVDDhDC+o9cQBUNDO1J79UEyXKD6M9DRggJkytM6Y/1C
	 S2YGMo+PiaFEeoKg1pphMlcmpxeJhFgUPzl27PFA1SjB+ygJu5mFsbGZiw+ZrxA86
	 0K4R4q9cyQ3VbemTjw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [33.33.33.2] ([193.25.251.95]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9Frd-1t4OG70EK7-006r1e; Mon, 14 Oct 2024 08:55:28 +0200
Message-ID: <f01fdf74-6f7d-4870-8607-c82065856986@open-e.com>
Date: Mon, 14 Oct 2024 08:55:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Artur Piechocki <artur.piechocki@open-e.com>
Subject: Re: [bug report] NVMe hotplug bug in kernel 5.15 with
 CONFIG_INTEL_IOMMU disabled
To: dongli.zhang@oracle.com
Cc: linux-nvme@lists.infradead.org
References: <2ea8ff1a-dcd6-4829-a096-63fa30d92b04@open-e.com>
 <61fbb21b-c0cb-4267-9275-d4a94ff89179@oracle.com>
Content-Language: en-US
In-Reply-To: <61fbb21b-c0cb-4267-9275-d4a94ff89179@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y7qcPwSmyCBDzLUprQp3Xl8/CZLI51oDfhuW6i4PjR7b3/ronEY
 38mpa8U9RvVOGMxNGAJecXkBxewJQxWL8zCcEtaPolqhqXDeXTriAe+Enzinorjrm5GBgGY
 crThdcecdQGjp66+rB3GoVTeCfasszMqU9VLGOhtO5gPY/73u3vtnqupFETPXZzNemdMeao
 Cr6ETV5wWLSf3mu9UqQ4w==
UI-OutboundReport: notjunk:1;M01:P0:VmSJUzn4o6U=;6oorsTFVv8/xzctBdm5zdvGiKQx
 0TepQCD4I0eRH4tcPtmsFl/DhWYtec8Dn3Y2CwftJhQhbxAeKj9c/HWqkkKVYbuNGV7oHNJYw
 p9yNtVZAE8tr12oxIo3lWt9eTFho/bD0HYtRAguGmtWXHaus6aVOzlLm/0+3d7D3fgAGKULtp
 osNGRKvfrO8kh8OkSQNWWrwof2dj2ZMiCczb5a8CUAp/UxytXwyFD3bIw9Dqqh0Jf4JVOdf4V
 DyuWiSeMISWMDYRBElZUO2nyTAavWOfsC5Tj47d2efE0yXmBnKOUtqYcJ9Kk5mwrnS8TTKe/7
 IVM+xRHbUjd82ql5XmDNvt+9PljBnb4DLM76Wr2pxBOkWuErLsFkxeJNyIpRzy7I83TYod6BV
 u5rzGky8nXBE1VWuMHEptBGxeNokB4NvjDnlJ95/XwHMhEF+2JMXruqT0OZCCTvFRMfudLETo
 49y6mocfoiAlnQ8pH+2v15IMjRwdjGb3cK5n0XLZF33hOEfZOX8N9fdKvvXaWsSpZoU8ZE5Qv
 kXC0bqtH9QT0PNx9Wp/CPtzqlJA3PegZKJv1I50hHgB+1GQzgmmWYOM3zyXrI6Bccrc40vGf3
 QBOqNlN4IsNjBH5WAESPZQsZR5UhYYsvaVOE4xYVQc8SmWapJ6pgsoDc0PvJ4qjec/CuMu0wp
 dgCJb33O05MqmQRKJfFzZBLmkxsPMkdR/C4y1Gg4C6SIPNjkwNzBjfkXQw8oTsxfw2ztnUj3v
 lEoW0giPJAW/w6/zE7MSu2AyO1hzu2w+g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241013_235533_933062_8EBE14E1 
X-CRM114-Status: GOOD (  17.37  )
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


> Hi Artur,
>
> On 7/8/24 1:26 AM, Artur Piechocki wrote:
>> Hi,
>>
>> I am experiencing a repeatable (potential deadlock) issue when
>> hotplugging NVMe devices on kernel 5.15. The problem occurs on a Ubuntu
>> 22.04.4 server environment when Intel IOMMU support is disabled in the
>> kernel configuration (CONFIG_INTEL_IOMMU is not set). This issue is als=
o
>> reproducible on the native kernel 5.15.161 without any Ubuntu patches.
>>
>> System Information:
>>
>>  =C2=A0=C2=A0=C2=A0 Distribution: Ubuntu 22.04.4 server
>>  =C2=A0=C2=A0=C2=A0 Kernel Version: Ubuntu 5.15.152 (also repeated on n=
ative 5.15.161)
>>  =C2=A0=C2=A0=C2=A0 Hardware: NVME Micron SSDPE2KX020T8, Intel(R) Xeon(=
R) Gold 5222
>>
>> Description of the Issue:
>> When hotplugging an NVMe device, the system experiences a potential
> Only for the sake of curiosity, may I have what does NVMe hotplug indica=
te?
>
> According to the log, the server is a baremetal, not VM (QEMU/KVM).
>
> Jul  5 09:49:11 tarox1 kernel: [    0.374071] Booting paravirtualized ke=
rnel on
> bare hardware

This could be due to the fact that the Ubuntu kernel has built-in
support for paravirtualization, but it doesn't necessarily have to use
it when the system is booted directly on bare hardware.

> Is there any method to hotplug NVMe to a running baremetal server?

The hotplug event occurred through the physical removal and reinsertion
of drives in an NVMe JBOD chassis that supports hotplug functionality,
though I=E2=80=99m not sure if you're asking about a different aspect of t=
he
process?

Additionally, the deadlock does not occur on kernel 6.1. However, I
would like to point out that kernel 5.15 is a long-term support (LTS)
kernel, and the issue still persists on that version.

> Thank you very much!
>
> Dongli Zhang


