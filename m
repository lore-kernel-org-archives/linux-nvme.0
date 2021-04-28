Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10E8C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 14:51:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD7F61008
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 14:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD7F61008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1GdL6DLKzXYgPdwers+S6uqhHRiED7PtzIMGqGrVeKg=; b=QrDzwup51b/rx6FtGgqbI3vz5
	GzPx/MfMcghbRt1mM3SqXcT3XOuO6TbZzrrUY/tfL0nDikuf0eRejOYlPFvLeeJMRbYUxhQFoe/lo
	htYa/2JSTWXwjDoXZklCPLJXnU4DvORe/Q5p23yd0/hZpup18p306pGBTmMbrTYsOyan6YNToxjcY
	G2/5ZA+3C/J641sVChcrsTtPmmrRfgBYUGpMRFDTgp8ahqEHngn/Lbd0Sg9FnWvJK7jU2XvH3JtT8
	fQykgVuVI52A/jrpB9mvKsgMfhwbCkV3mCgngv0oKdjuV2pZZRvsIw5ILdF+nRccA9DK3sJT/2JKg
	kIZf+w5Cw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lblXD-003fEv-8H; Wed, 28 Apr 2021 14:51:27 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lblX8-003fEI-4B
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 14:51:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=fiJ4ZkgkZjdwDEkXyL7+mcm098hxCoAsqRZ72SMrgS8=; b=H4ZqkbH7VQa0nSYrB9Mjdn9lxl
 W72gIG17MtYmlKG84S64OcyUikQ6VcoqLeDGOtgJW0uB4eDDhNFFeE9HA8S9K7WngRWPuRg/PY+m2
 eywmZWYr/zv0PUJkphhVSY8y7SGiay/rp1uvVYPtUDdsvBnI29HVQ6OFPbTLonrvRex3iIzZnTEpQ
 zm1B5aCfHzg66k2eqTNcs2VzHBpd2PbjYFlBAxqVp7A+/fMQYstC3VEjcKei8MH5vZfsfN3SGJpd9
 Z11Nxl1JA4WqHWdP7CYOg8vYttSu3AQSeojMGQq+FgAckFJzaXJv/Cy9M9tw6/OQGO7V4QgmRG1cn
 4VojKusg==;
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lblX5-00HVHS-GA
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 14:51:20 +0000
Received: by mail-pj1-x1033.google.com with SMTP id
 f6-20020a17090a6546b029015088cf4a1eso9263074pjs.2
 for <linux-nvme@lists.infradead.org>; Wed, 28 Apr 2021 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fiJ4ZkgkZjdwDEkXyL7+mcm098hxCoAsqRZ72SMrgS8=;
 b=VVM/kakAG7PmbcQH2cNFmOM/RFTneNgnfhpXQNaQu8CzPQWN69mT29ZnRhP4aNq+ym
 Wcvhp3dqk3ZUsr7VcZaqGgamXFyS9dbL9nsogWpWYsJ1yCsR88EdwaXgh0RGSSU1Bp7D
 LoQGbAmIIgGbaBUVPTuQhvIX3pox6T5siZYrJPes/pD/bTC8ppBemQtj50IRj5qitKdb
 dp83UwPudsOHNoITzT4kmmT09GNmEpGK6czejrTY8VmW+Nv+6IGyTMXi4cnDObbQO9Ye
 G+Sm1BngWVGCzCXUvEbq/3N/BVpWzaAIbdxna34lJIXmStUp/Ksj2TyZZWye5XBjLutQ
 HqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fiJ4ZkgkZjdwDEkXyL7+mcm098hxCoAsqRZ72SMrgS8=;
 b=Wr4LQ64t0c4FSG61OrETBy2JToe+lD1UKuvxlsUtrgnVMgnpDXje7cXos7h+6UNsBD
 Fp8NTHLF3Z0t337eQx9o9mvroSFZAmcGhk3tKxOmxLTpU1uWtjU/QRq9JJdT04Qf1bgK
 zDScukmKPgPq+h/hyiXVht8N0C+9ZbH5mmPnCqwRT7YyznS/2VpJ7uvEMXOWR1W5Gu8h
 K3gE3TsEUrKEuraQ8Y0sR5rwD80BcMj4qVOni2/9J5hVg0NhWzJzwdK/qxAILtRYVeq7
 d8NqND7+bIeQsYDkqugkKpd2QjXOmnxjwbT9QMiI2UukZkaPdGf9TDStfPTv4djFqpKn
 jfjw==
X-Gm-Message-State: AOAM531ITmyDYVw5N1Q/ByDLf0duZoUT+IWFbYBKOzeBwxZgfXYsq1H5
 9lHByVzi8bn4qvlZc6+9FXY=
X-Google-Smtp-Source: ABdhPJwqEI3rfTmIpzYfv6Knpgq06uq+XT4DNeryolhBTOTmqR/Q9hZK2KgLBCC24lD/03dZFAtjSA==
X-Received: by 2002:a17:90b:109:: with SMTP id p9mr7709601pjz.12.1619621477920; 
 Wed, 28 Apr 2021 07:51:17 -0700 (PDT)
Received: from [192.168.1.27] (ip174-67-196-173.oc.oc.cox.net.
 [174.67.196.173])
 by smtp.gmail.com with ESMTPSA id z2sm27812pfj.203.2021.04.28.07.51.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Apr 2021 07:51:17 -0700 (PDT)
Subject: Re: [EXT] Re: [RFC] qla2xxx: Add dev_loss_tmo kernel module options
To: Arun Easi <aeasi@marvell.com>, Daniel Wagner <dwagner@suse.de>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, linux-scsi@vger.kernel.org,
 GR-QLogic-Storage-Upstream@marvell.com, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>, Nilesh Javali <njavali@marvell.com>,
 James Smart <james.smart@broadcom.com>
References: <20210419100014.47144-1-dwagner@suse.de>
 <YH8QzgWiec8vka20@SPB-NB-133.local>
 <20210420182830.fbipix3l7hwlyfx3@beryllium.lan>
 <alpine.LRH.2.21.9999.2104201642290.24132@irv1user01.caveonetworks.com>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <e6800e85-a8c0-efda-6be9-558dc2a5b898@gmail.com>
Date: Wed, 28 Apr 2021 07:51:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.9999.2104201642290.24132@irv1user01.caveonetworks.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_075119_573781_A0C1C3AC 
X-CRM114-Status: GOOD (  26.79  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/20/2021 5:25 PM, Arun Easi wrote:
> Hi Daniel,
> 
> On Tue, 20 Apr 2021, 11:28am, Daniel Wagner wrote:
> 
>> ----------------------------------------------------------------------
>> Hi Roman,
>>
>> On Tue, Apr 20, 2021 at 08:35:10PM +0300, Roman Bolshakov wrote:
>>> + James S.
>>>
>>> Daniel, WRT to your patch I don't think we should add one more approach
>>> to set dev_loss_tmo via kernel module parameter as NVMe adopters are
>>> going to be even more confused about the parameter. Just imagine
>>> knowledge bases populated with all sorts of the workarounds, that apply
>>> to kernel version x, y, z, etc :)
>>
>> Totally agree. I consider this patch just a hack and way to get the
>> discussion going, hence the RFC :) Well, maybe we are going to add it
>> downstream in our kernels until we have a better way for setting the
>> dev_loss_tmo.
>>
>> As explained the debugfs interface is not working (okay, that's
>> something which could be fixed) and it has the big problem that it is
>> not under control by udevd. Not sure if we with some new udev rules the
>> debugfs could automatically discovered or not.
> 
> Curious, which udev script does this today for FC SCSI?
> 
> In theory, the exsting fc nvmediscovery udev event has enough information
> to find out the right qla2xxx debugfs node and set dev_loss_tmo.
> 
>>
>>> What exists for FCP/SCSI is quite clear and reasonable. I don't know why
>>> FC-NVMe rports should be way too different.
>>
>> The lpfc driver does expose the FCP/SCSI and the FC-NVMe rports nicely
>> via the fc_remote_ports and this is what I would like to have from the
>> qla2xxx driver as well. qla2xxx exposes the FCP/SCSI rports but not the
>> FC-NVMe rports.
>>
> 
> Given that FC NVME does not have sysfs hierarchy like FC SCSI, I see
> utility in making FC-NVME ports available via fc_remote_ports. If, though,
> a FC target port is dual protocol aware this would leave with only one
> knob to control both.
> 
> I think, going with fc_remote_ports is better than introducing one more
> way (like this patch) to set this.
> 
> Regards,
> -Arun

Thanks Arun,

I think we're all better off if the qla exports the nvme nodes via the 
scsi-side fc_remote_ports.  In the end - we will commonize a fc 
transport that then sits above scsi and nvme and will definitely be 
compatible with what's there. The registration with scsi was rather 
straight-forward for lpfc, so I assume it will be for qla as well and 
the devloss interface, although kludegy to have the driver propagate the 
scsi callback to nvme, also isn't much.

I also don't think we want to keep creating new mgmt points. it's 
already ugly enough.

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
