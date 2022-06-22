Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F11C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 10:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iqg+adngzrSC0Nh0jzb1IEWOTD8VUlf+tMxQ8exTSvc=; b=qglgWhtMZ0Kuwsjr4aq5hGfmHJ
	w40R+p/Zmt3y/sdRyqV3cnpiVCCulDfYYYwl1PVO4ocdzxO/IcbpN5aOSXRlzva7dTN/sUF4kfv4q
	5QZo/N0Ca7eitlb9mUwnaQhIOo81bvIImjcY/T/jeDKf386HdCn5nFgZLD5vvhxn0Df4AmoFto2dT
	KxQUtKQmtNSdoV1G0csPVd4WV2JbAWX+64l8jdupSPW/K3llXfRkndi0KXVXVTjelBjkvJg9rUOSq
	W9sUR7H+2UplHgX3Rv7+/TrtbbIYtlT3/m/UEpGagXk6bgCBz07RR375P5PzHxBYMReS0gEaBZViB
	BubGufyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3xD8-009lVp-K0; Wed, 22 Jun 2022 10:03:46 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3xD5-009lV1-7T
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 10:03:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2BD1D21B2E;
	Wed, 22 Jun 2022 10:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655892221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iqg+adngzrSC0Nh0jzb1IEWOTD8VUlf+tMxQ8exTSvc=;
	b=y1EKXloVKrQoAJ9K5LXyCLsC0GxR4kyh+IrtBQ/5OooHQfbsBWjm6ycaquZ5AX3oqbsqia
	879Awe/jnj41kDAwRIt1HV/kl3F8aVH2rKog2f02DttZKt88dJL3B5mn8xlnjjzlfJfsC6
	9tuVnTnqDckFy3vnDojIG2CjwXy3K0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655892221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iqg+adngzrSC0Nh0jzb1IEWOTD8VUlf+tMxQ8exTSvc=;
	b=H003VHtjSwSqPuo06ROQcwgdM3hcBqpMH6e3udrcfy8HNGl1enMtBYSQsW+ADtOZ6gPqIg
	oU+tjWTsflHdJaBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19D4513A5D;
	Wed, 22 Jun 2022 10:03:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WyABBf3osmIcPwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 22 Jun 2022 10:03:41 +0000
Message-ID: <05b8a18b-d052-0f06-c43b-939766d5d5df@suse.de>
Date: Wed, 22 Jun 2022 12:03:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv16 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220621172414.82847-1-hare@suse.de>
 <3c375526-a967-0856-0f8b-da08f21c7d80@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3c375526-a967-0856-0f8b-da08f21c7d80@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_030343_457337_2A202CDD 
X-CRM114-Status: GOOD (  25.46  )
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

On 6/21/22 23:22, Sagi Grimberg wrote:
> 
>> Hi all,
>>
>> recent updates to the NVMe spec have added definitions for in-band
>> authentication, and seeing that it provides some real benefit
>> especially for NVMe-TCP here's an attempt to implement it.
>>
>> Thanks to Nicolai Stange the crypto DH framework has been upgraded
>> to provide us with a FFDHE implementation; I've updated the patchset
>> to use the ephemeral key generation provided there.
>>
>> Note that this is just for in-band authentication. Secure
>> concatenation (ie starting TLS with the negotiated parameters)
>> requires a TLS handshake, which the in-kernel TLS implementation
>> does not provide. This is being worked on with a different patchset
>> which is still WIP.
>>
>> The nvme-cli support has already been merged; please use the latest
>> nvme-cli git repository to build the most recent version.
>>
>> A copy of this patchset can be found at
>> git://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel
>> branch auth.v15
>>
>> The patchset is being cut against nvme-5.20.
>>
>> As usual, comments and reviews are welcome.
> 
> Hannes, did you see my panic report on a malformed dhchap_ctrl_key?
> 
> Also, why does the dhchap_ctrl_key not passed when connecting
> via discovery?
> 
> I have in the target:
> -- 
> # grep -r '' /sys/kernel/config/nvmet/hosts/
> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f/dhchap_dhgroup:null 
> 
> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f/dhchap_hash:hmac(sha256) 
> 
> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f/dhchap_ctrl_key:DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVN6mFaS7YQOMYhk9zSmlatobqB8C: 
> 
> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f/dhchap_key:DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I: 
> 
> -- 
> 
> Then on the host I have:
> -- 
> # cat /etc/nvme/config.json
> [
>    {
>      "hostnqn": 
> "nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f",
>      "hostid": "14f15c4e-f6cb-434b-90cd-7c1f84f0c194",
>      "dhchap_key": 
> "DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I:",
>      "subsystems": [
>        {
>          "nqn": "testnqn1",
>          "ports": [
>            {
>              "transport": "tcp",
>              "traddr": "192.168.123.1",
>              "trsvcid": "8009",
>              "dhchap_key": 
> "DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVN6mFaS7YQOMYhk9zSmlatobqB8C:"
>            }
>          ]
>        }
>      ]
>    }
> ]
> -- 
> 
> And when I do connect-all (i.e. connect via the discovery log page:
> -- 
> # grep -r '' /sys/class/nvme/nvme1/dhchap*
> /sys/class/nvme/nvme1/dhchap_ctrl_secret:none
> /sys/class/nvme/nvme1/dhchap_secret:DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I: 
> 
> -- 
> 
> This means that I can corrupt the dhchap_ctrl_key entry in the config
> and no one will care (because it is not authenticating the ctrl if
> dhchap_ctrl_key is not passed)
> 
> I think this is something wrong with nvme-cli/libnvme though...

Using the latest patches (and latest nvme-cli) it works if I specify:

nvme connect-all -t tcp -a 127.0.0.1 -s 4420 \
   --hostnqn 
nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f \
   --hostid 14f15c4e-f6cb-434b-90cd-7c1f84f0c194 --config config.json

(You have to specify --config to instruct nvme-cli to use the 
configuration file)

We have had some fixes for the config handling recently, so maybe it's 
enough to update nvme-cli.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

