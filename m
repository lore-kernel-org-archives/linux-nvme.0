Return-Path: <SRS0=Br1a=5M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F560C43331
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 17:50:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439862071B
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 17:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kqRS7FCE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FepuvUCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439862071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S6ia0U3w3C722uA9djS7zW+7aFx7rwQ5zzPRcg9aipQ=; b=kqRS7FCERa/GXrh7jC6GQQ8hM
	D2BvlMtnxfkPWiK9QNcLynQbC5uq606daTCwtqP9N+FdXGTTNwDBByKVbdB8Atwh6+G3t5zSojEmH
	W6MyVQSt9JP/+6CFVtR2L8OaAELgMwQQH6h0eGh/kUnseGy9jiIi89adst1fJlj4e4q7HeoQsZAI3
	XObYajE0UTZehJrOwMMGhGzDHRKsDe+Id4hThmGupC9T86USDtM56i+7ZBP6uW54G5q0uSdS0O7tn
	RpypbeyHp5SOSc4BfCWYIoBJKaZs+adGE4ebmpk/dDbVxcyrXEMNRqIAwOAJe3urfkQXzvqSQrO3Z
	6gWrckdRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHt8B-0001z8-73; Fri, 27 Mar 2020 17:50:55 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHt88-0001yR-GX
 for linux-nvme@lists.infradead.org; Fri, 27 Mar 2020 17:50:53 +0000
Received: by mail-pf1-x444.google.com with SMTP id c21so4190453pfo.5
 for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2020 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=NbkhpIuOWJuMUESyBT70pEHnCNQNnr4hZwihXUNVzQo=;
 b=FepuvUCT4M7sYuheBzr+EeuSk+ExYWaEHm4vduyKQeyB9nbFCCeXtpNLNfBgTSIPfR
 /c9Rl3Kexj21kQH/VLxhfDhzwPu+C5Up5xqGa6BEtoS9dfkVxu6fmgAj2AL8dafjagCt
 iw4TGLi/kPe7V8juR423lWDwA6vSOGT2JoLIWnb7/qE2sVoaR3+f4d2iYWX46lbBt8hP
 9kp7xCgv7LUaqNN513KW7FhO/oxpnhJarIu33p08M4KVPitW1Oy/zt5Gu6dhQ9dR8KBI
 6dxi70liJkX8NdqU8rCp5bTK2PtksgkyrQPdwFZVGDLwVH57PjnOyfC0t4IOmYVC2lWR
 zYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=NbkhpIuOWJuMUESyBT70pEHnCNQNnr4hZwihXUNVzQo=;
 b=CgUJTkdkc5kW0Wi2sWz5OmqpBDtluI5GiAsX8zDpESegpIAOSyTB0xuStGF7WqeAu1
 euMcoySLA2fTXYVbzUKJb4hBssM0JJPadirma5H8LFPd3rt/immXdIP7VK16MRs1BqfD
 PTcfSHWiFQO+iRAts4ij8ZK4jCfua1uh7zum+wgtVNaL3l3JZ2xze1xg+WMy/me1VHPs
 sJzCcdoQ118zvTVXwB60Bd5h5Gm1j5OdT2aB5fwr5KDkVf/0O1aDj5K5jyhGOpniQnsv
 Bs5VfG1Pyh972RRKAas1SZ3zCUGJxmGYYYSNOrbF0leIN+/RbNfR9k3GXzkTXMnTrdGm
 CXLA==
X-Gm-Message-State: ANhLgQ0A8XP6pr5hMmk8lqPoBhfVkIUEnRRanhau7gE37/YGk5pTaP0H
 NoUVBMET7FBDDJuCXiIkC8cOyyKn
X-Google-Smtp-Source: ADFU+vt4h9qyiuqaP6qfUepMf7qUu1HnxdDZp2MqovLbOLxQQnGCUsvBgca0Tf3MuFWzw9d7V6rivA==
X-Received: by 2002:a65:68cb:: with SMTP id k11mr460554pgt.78.1585331448562;
 Fri, 27 Mar 2020 10:50:48 -0700 (PDT)
Received: from ?IPv6:240b:10:2720:5510:5c8f:768a:547c:1376?
 ([240b:10:2720:5510:5c8f:768a:547c:1376])
 by smtp.gmail.com with ESMTPSA id t11sm4189116pjo.21.2020.03.27.10.50.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 10:50:48 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
To: Keith Busch <kbusch@kernel.org>
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
Message-ID: <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
Date: Sat, 28 Mar 2020 02:50:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200327_105052_554833_B20A2100 
X-CRM114-Status: GOOD (  12.14  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 2020/03/25 1:51, Tokunori Ikegami wrote:
>
> On 2020/03/24 9:02, Keith Busch wrote:
>> On Tue, Mar 24, 2020 at 08:09:19AM +0900, Tokunori Ikegami wrote:
>>> Hi,
>>>> The change looks okay, but why do we need such a large data length ?
>>>>
>>>> Do you have a use-case or performance numbers ?
>>> We use the large data length to get log page by the NVMe admin command.
>>> In the past it was able to get with the same length but failed 
>>> currently
>>> with it.
>>>
>>> So it seems that depended on the kernel version as caused by the 
>>> version up.
>> We didn't have 32-bit max segments before, though. Why was 16-bits
>> enough in older kernels? Which kernel did this stop working?
> Now I am asking the detail information to the reporter so let me 
> update later.
> That was able to use the same command script with the large data 
> length in the past.

I have just confirmed the detail so let me update below.

The data length 20,531,712 (0x1394A00) is used on kernel 3.10.0 (CentOS 
64bit).
Also it is failed on kernel 10 4.10.0 (Ubuntu 32bit).
But just confirmed it as succeeded on both 4.15.0 (Ubuntu 32bit) and 
4.15.1 (Ubuntu 64bit).
So the original 20,531,712 length failure issue seems already resolved.

I tested the data length 0x10000000 (268,435,456) and it is failed
But now confirmed it as failed on all the above kernel versions.
Also the patch fixes only this 0x10000000 length failure issue.

There was confused and sorry for that.

Regards,
Ikegami


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
