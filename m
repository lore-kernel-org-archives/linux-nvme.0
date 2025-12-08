Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A41D3ABEF
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Dec 2025 08:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oHZu52l6cz+FXkGQvcVvd8GHMHrhu9c82SQRfVFrwnQ=; b=KU1KNTlArBgp5UwxbWaPVropqo
	28qUC36SDhUYMwmSy8EETF2eYLoaBgey5N1Bd7sr6Na4CsFykeTLM0DpBLaXVGsD9uJ3Ng5rC0mjz
	7hOktVz3+MSeWbaoC2Ebv5AawkfiEYfxR8J1Vc/PCA2rH8lHIg1WAszkox4LBnNDLk5zKlTTt/2GC
	9ujxazhv6n0nP7rcVpVBfXeJEPdf/uF59BBwQUowh0eV6HZ/S2xtde3RjTTWAjC596ztRYT3g7hZb
	kaOsVKfCVMtl+qXWBzM5z8EmvfGuAJBIVdl8tQIZiRrxuWjYLAxye3XKRPZOFANR91P/6OEYQvH31
	PmrGd2Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSWqp-0000000CpRE-40bi;
	Mon, 08 Dec 2025 08:44:11 +0000
Received: from ns3.fnarfbargle.com ([113.52.145.23])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSWql-0000000CpQc-1VNm
	for linux-nvme@lists.infradead.org;
	Mon, 08 Dec 2025 08:44:09 +0000
Received: from [10.8.0.1] (helo=home.fnarfbargle.com)
	by ns3.fnarfbargle.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <brad@fnarfbargle.com>)
	id 1vSWqO-0007hO-2V;
	Mon, 08 Dec 2025 19:43:44 +1100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oHZu52l6cz+FXkGQvcVvd8GHMHrhu9c82SQRfVFrwnQ=; b=mURRAzmP5Cn8SQU6swHpGE34YB
	F2XuC83iKX5kFihmXNg7TQHlwO9R41Mk1i8dlg+eVQxiiLy5ElRO3IAmI0jn42qmsqwaY2cm+3+o6
	eol1PE0QsWu3L0Ps4iEUC0oUchpCWPuUoP8BhSmswVPoK8CvmU9mQGGtNw34MytG6DRs=;
Message-ID: <f6f1a5fd-814e-49f4-901e-28110feed5ee@fnarfbargle.com>
Date: Mon, 8 Dec 2025 16:43:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
To: Justin Piszcz <jpiszcz@lucidpixels.com>,
 =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <galileo@pkm-inc.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 linux-raid@vger.kernel.org
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
 <CALtW_ajVLbtUfVkKZU3tsxQbHMZsJR=jHK7PQNmvmSgjVhiUyg@mail.gmail.com>
 <CAO9zADx+5cNAxaz4R7SAndY5EX1z4V8i1e=rAdBbOTmxLmcopw@mail.gmail.com>
Content-Language: en-US
From: Brad Campbell <brad@fnarfbargle.com>
In-Reply-To: <CAO9zADx+5cNAxaz4R7SAndY5EX1z4V8i1e=rAdBbOTmxLmcopw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_004407_713625_E82B4399 
X-CRM114-Status: UNSURE (   8.76  )
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

On 1/12/25 22:14, Justin Piszcz wrote:
> On Tue, Nov 25, 2025 at 10:19 AM Dragan Milivojević <galileo@pkm-inc.com> wrote:
>>
>>> Issue/Summary:
>>> 1. Usually once a month, a random WD Red SN700 4TB NVME drive will
>>> drop out of a NAS array, after power cycling the device, it rebuilds
>>> successfully.
>>>
>>
>> Seen the same, although far less frequent, with Samsung SSD 980 PRO on
>> a Dell PowerEdge R7525.
>> It's the nature of consumer grade drives, I guess.
> 
> As this affects multiple NVME manufacturers, are you aware of any
> consumer-level NVME drives that do not have this problem or is moving
> to U.2/U.3 server drives necessary to avoid drives dropping offline?
> 
> 

Late to the party, but I've got Samsung 960Pro/970evo/980Pro, Crucial P2/T500, Kingston KC2000 and SKHynix P31 nvme drives in 24/7 machines and have *never* had an issue like this. 
The 960Pro suffers from long term slowdown, and the P2 is just an awful performer, but none of them have ever suffered from connectivity issues. The Samsungs, Kingston and the T500 are all in arrays.

None of these machines get power cycled and they might get rebooted once a year (or thereabouts).

