Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF779C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 15:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kU+GLJEFYIiN6NGm+q/bq337K/F3drtFqv3LO1H4fKE=; b=i3eoQAXLa09FcC6F6LhhaFtGT5
	X5bUjxDpdnzN/h1QDeZ5VPtuXBVCutbF+cR3Z3FDdlGadMAIgA2XKW2VBMA5bJpOcEZmZsQSD2yhX
	jVCxhhhOJoBxbemFfcXEMozeTR/cC7h79Z9gWN/GSQMET5PI7GofXvTuf8v16RJHoEwTABBPcDuyI
	5qZyRpRALTpuMa6MPcyb4f5ZWSINEKAIRZkVxLNIy3Oke+9NdDRLlXpc1lLHXLl7dwzpER9fNRpgG
	ZZD67LV6mIX6wxFfum9SJXA+XkXsG0oM2XTHyMHSwVwljWlwlNjNd3bTjS+kyD/NjEcfrzfvYZsyt
	iSco2bhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU9M5-009lc2-6K; Tue, 15 Mar 2022 15:45:01 +0000
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU9M1-009lae-OM
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 15:44:59 +0000
Received: by mail-il1-x12b.google.com with SMTP id b9so12181889ila.8
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=kU+GLJEFYIiN6NGm+q/bq337K/F3drtFqv3LO1H4fKE=;
 b=gT6Y1bbmKjfoWVGM6TuXc6Ew3txTgEY9NUokJyBPFxsps4dxNt108edzQMlliVyula
 oSIaGoB2zOd7tJBXXETitXby9wwwghsCALOxo9SclxNe/c2zLW2xT7DuzfGcx2oj1B+d
 xUaer0hBghpARihJCQG30tsZLNXZpVr0PU0tzOsBSY4KT6vt2STQAbQ4ZmCFXva3rwtk
 8q7qLksIoMvpIw/WA2Kbc2QvQ2NIV4aADl5cST4HOY2frRlQWn1fH23PbDGkRljqI9NN
 isLqrW4T0Ot7sJZElLaOFWkBsmvrMFUQ21PRhs8farpcJiB9D4vvpUd0tvp1DFjMtJWo
 41wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=kU+GLJEFYIiN6NGm+q/bq337K/F3drtFqv3LO1H4fKE=;
 b=6JvChgmS5mPD0W4hfr4EHzo7cYAEATFVg5+P6jEdBK3l9i7Jwb/b8g0PMdHgw93RKx
 L84YadxcnRKPliNE5ShgFnYVcR2Pqup00oNxOqROl9ooxv+GexFLI4v6IdSPQ/wxJdZc
 F/CKo/aiFoTbaTKsggPjDGJUZhrz+jPUgxXBGGurTg5jj7cGPIYIjS5RvfxuqVMyXfQD
 LE9mOU40Fze9WvQrsq9kNOjYhXUpak/Drbj0Rr+EkOA4+IjdIM93u9m5T11HTRaMAVD1
 nTH5TXtEqcoxZeGDgdT/n52bSi3W9x8MwZ/ql2YL5Pv0FswNNmgk8ccsTC3oCPByeyRI
 z+VA==
X-Gm-Message-State: AOAM530ibOXOgk9iCiUBsxJb1yMQvYCamiGzSvkvnRgO+uZCaczI4Abh
 jgWxsjpJv3o8cu14C6g9Aq6c6w==
X-Google-Smtp-Source: ABdhPJyych0DqX/cH/hqdWSDTCrkBK3odSgH+RTperxlzi4UKTip9ytPQ9AbkvcaBJmp6mZx9NU3nA==
X-Received: by 2002:a92:ca45:0:b0:2c7:c473:6785 with SMTP id
 q5-20020a92ca45000000b002c7c4736785mr800177ilo.40.1647359095651; 
 Tue, 15 Mar 2022 08:44:55 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a6b740a000000b006413d13477dsm10427409iog.33.2022.03.15.08.44.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 08:44:55 -0700 (PDT)
Message-ID: <95588225-b2af-72b6-2feb-811a3b346f9f@kernel.dk>
Date: Tue, 15 Mar 2022 09:44:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Content-Language: en-US
To: "Luca Porzio (lporzio)" <lporzio@micron.com>,
 Avi Shchislowski <Avi.Shchislowski@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, "Bean Huo (beanhuo)"
 <beanhuo@micron.com>, Manjong Lee <mj0123.lee@samsung.com>,
 "david@fromorbit.com" <david@fromorbit.com>
Cc: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "song@kernel.org" <song@kernel.org>,
 "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
 "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
 "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
 "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
 "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
 "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
 "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
 <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk>
 <c27a5ec3-f683-d2a7-d5e7-fd54d2baa278@acm.org>
 <PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com>
 <ef77ef36-df95-8658-ff54-7d8046f5d0e7@kernel.dk>
 <bf221ef4-f4d0-4431-02f3-ef3bea0e8cb2@acm.org>
 <800fa121-5da2-e4c0-d756-991f007f0ad4@kernel.dk>
 <SN6PR04MB3872231050F8585FFC6824C59A0F9@SN6PR04MB3872.namprd04.prod.outlook.com>
 <0c40073d-3920-8835-fc50-b17d4da099f0@kernel.dk>
 <CO3PR08MB7975EF4B014E211ACFAB7AF4DC109@CO3PR08MB7975.namprd08.prod.outlook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CO3PR08MB7975EF4B014E211ACFAB7AF4DC109@CO3PR08MB7975.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_084457_897317_99E207C8 
X-CRM114-Status: GOOD (  28.57  )
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

On 3/15/22 9:36 AM, Luca Porzio (lporzio) wrote:
>>
>> This isn't some setup to solicit votes on who supports what. If the code isn't
>> upstream, it by definition doesn't exist to the kernel. No amount of "we're
>> also interested in this" changes that.
>>
>> What I wrote earlier still applies - whoever is interested in supporting lifetime
>> hints should submit that code upstream. The existing patchset to clean this
>> up doesn't change that process AT ALL. As mentioned, the only difference is
>> what the baseline looks like in terms of what the patchset is based on.
>>
> 
> Jens, 
> 
> Actually we might work to issue a patch and revert the patch plus add
> the code that Bean and Bart mentioned which is currently Android only.
> The reason it has not been done before is because for now it's not
> production yet but it may soon be that case.
> 
> Would this patch revert be an option and accepted as a closure for
> this discussion?

What patch revert? It's not clear to me which patch you're talking about
here. If you're talking about the "remove the per-bio/request write
hint" patch, then no, that's certainly not being reverted. See previous
replies I made and also below for why, and let's please stop beating
this dead horse.

> Another option (which I actually prefer), if I ask for a MM & Storage
> BoF discussion on storage hints where I can show you the status of
> temperature management and my studies on how this is beneficial for
> storage devices. 

As long as it's accompanied by code that implements it, then that would
be fine.

> Would this be more beneficial and maybe get some wider consensus on
> the write hints?
> 
> After that consensus reverting (or agreeing on a new approach) will be
> easier.

As I've said multiple times, whenever code is available, it'll be
reviewed and discussed. I don't like to discuss hypotheticals as too
many times in the past there's a promise made and expectations built
only for nothing to materialize. As it stands, the only in-kernel user
of the hints is gone, and that means that the support code is being
removed. We NEVER keep code in the kernel that doesn't have a user, as
it can't get tested.

Submit your patches when they are ready, it really has no bearing on the
currently queued up changes to write hints.

-- 
Jens Axboe


