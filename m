Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F8DC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 06:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F44Re5druFb2n+jHd2fhxfdmytWrHjlZt8ybcT2gBPw=; b=reRDCv2GqfHNkKhZekzn7aK5gQ
	MXo7mF2wEUSCnY2lKa8fc4o4gsxRFHBP3VlkDbUa+zcF0pP/0yGCm/kGEz8XlekgDe1aqTXgmc1Gb
	99GQObkZOnjl3P5jpGEzJtwcVttjai154uWuGhAp8njaTrdUYdtOyYMW0KBZjRJcMEstp+leE0KM+
	K8xbs9lhs91ybgqUyMpEKX+umIryhBXaJK9OuETQf9zDHTubqGLplYDS+dDwV2bQSuaqXvcI0R34H
	yoe9QMzvufgC/DXm6BKCOFFV/vL+ax+MbHK8gFQ7C5UUxuCfRY35W7W/EA8M6b7djrMpxtQ1z3YCZ
	jXkyATUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3twu-008prV-K7; Wed, 22 Jun 2022 06:34:48 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3trt-008nyj-9g
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 06:29:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 24EF321B9C;
	Wed, 22 Jun 2022 06:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655879375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F44Re5druFb2n+jHd2fhxfdmytWrHjlZt8ybcT2gBPw=;
	b=YF7X18i3VFxHDlSJxisfthajD6b3CrstssFTHDbZc5eqV8PO2qcDvVA7RiV/6+3gYA81Ts
	JoYBVO09g0gBI8jBTSzd+hUjL03EeFFgdYfsFZoBMk/P2QbwL9eGSeu7cvXfPa1EakLYLn
	bMgo5P98fRsQNapyjDTM8JxIMWajPtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655879375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F44Re5druFb2n+jHd2fhxfdmytWrHjlZt8ybcT2gBPw=;
	b=o46PCXBvo2mlfeRFxdz0F16O4ayld1WbkM/NvVvUEPylLcil51jzfpkCFeVQAHo0vuFygA
	yshMkvN4mHX7UZCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C22B134A9;
	Wed, 22 Jun 2022 06:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id KLstAs+2smJOTAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 22 Jun 2022 06:29:35 +0000
Message-ID: <5406f9b5-000e-e543-020e-57de69f00413@suse.de>
Date: Wed, 22 Jun 2022 08:29:34 +0200
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
X-CRM114-CacheID: sfid-20220621_232937_552944_14C3935B 
X-CRM114-Status: GOOD (  28.07  )
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
Unfortunate design on both ends.
It's the host who requests controller authentication.
So if the host doesn't request it nothing will happen.
But that also means that controller authentication is optional, and so I 
didn't feel comfortable to refuse connections for an optional feature.

But we can make that a real error, and refuse the 'connect' call if the 
controller key is invalid. Might be a better choice after all.

Something like this would help:

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 53184ac76240..a03f41fa146e 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -842,6 +842,10 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int 
qid)
                 dev_warn(ctrl->device, "qid %d: no key\n", qid);
                 return -ENOKEY;
         }
+       if (ctrl->opts->dhchap_ctrl_secret && !ctrl->ctrl_key) {
+               dev_warn(ctrl->device, "qid %d: invalid ctrl key\n", qid);
+               return -ENOKEY;
+       }

         mutex_lock(&ctrl->dhchap_auth_mutex);
         /* Check if the context is already queued */


Is this what you had in mind?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

