Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF65C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 10:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dMTwDPVjU8iRPIC3WLKX50je76PSl1QgV6IJkCaT0oc=; b=1X80sJ39bot1NBA5Ex3iv2pnuH
	yVj3iLA/zyQRYsS6o8DiXgtql8kIEkYY6VhJ9ytG+4YKkhYefZOJ0+PwLwS7jKZtAJwTOgSdcof+8
	iAYr155inEFpOSCqrzejc0SgYwLziB0UwP2yhXSmmvMNCKErp4pVTx3xSAjNoWTkxCx6dLZIpAPuE
	3df8m2W7bLY9IInXxSC/WmmA3icI6M+nQr8klKOCK+4Gw8F7iSghCz+yFZ5VEiYp4+84nDD6nV6qg
	dv+1nRDzoDMSQvF8GtxwVb8JIxz02z0cTAdFKEHH0e/oR2TY0041ALWzOi87lV6H2QZ8pPp7R3t56
	O0tTy8TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3xZC-009t0j-0u; Wed, 22 Jun 2022 10:26:34 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3xYn-009soU-TD
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 10:26:11 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A7FD621C51;
	Wed, 22 Jun 2022 10:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655893567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dMTwDPVjU8iRPIC3WLKX50je76PSl1QgV6IJkCaT0oc=;
	b=okJ/aIC7SPbRu1h1M5aL5l9+PYBj8LewnfdaIQODUg62m6CaOOORHFPU44B+nXgTzEy5R6
	yMr9xHcE8oQpM/BpROBxWEHDJ+yn0e+guLnOvRkFF7/Mju/rXOGDCuEHT9BQ+HmwwpZ14P
	unyVq54uI9LR3yAwYuSMTbxQro3kAoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655893567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dMTwDPVjU8iRPIC3WLKX50je76PSl1QgV6IJkCaT0oc=;
	b=dHCeDUZa2JIopxMrwOiBk/ax/fAZwxGH9B4GPIYAja67LRbYSZZpPZWk3BYrDgO8zq3aEj
	IiEc+DPe4ALrXxCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75EAA13A5D;
	Wed, 22 Jun 2022 10:26:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id OnyvGT/usmKzSgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 22 Jun 2022 10:26:07 +0000
Message-ID: <7cedadf1-e1ef-f01b-2265-182181b58d18@suse.de>
Date: Wed, 22 Jun 2022 12:26:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220621090255.69549-1-hare@suse.de>
 <20220621090255.69549-7-hare@suse.de>
 <f8f0a631-6752-096c-4e85-bcde9bb2869e@grimberg.me>
 <22236c51-90cd-1707-05b8-3772ef4c548d@suse.de>
 <ab4aaf2b-444f-2b3c-091a-396de62afbd1@grimberg.me>
 <a32afeac-983c-2ea4-e693-2d46411e7f4a@grimberg.me>
 <3784f492-67f8-c75a-dccf-7f7272e0b4ad@suse.de>
 <b0e6fa33-ed59-eaa7-3629-3d72430b8ad6@grimberg.me>
 <c06b6657-b015-3ff4-6044-8e800aaeae81@suse.de>
 <5c650ecb-1459-d47c-ed9e-ebd552fe5ffc@grimberg.me>
 <2200e5f1-8af0-25bc-72fb-eac8eaaeeb72@suse.de>
 <e5de2ab8-cf63-d882-1e5d-e94f125bbaa3@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e5de2ab8-cf63-d882-1e5d-e94f125bbaa3@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_032610_144125_150A2FA9 
X-CRM114-Status: GOOD (  30.39  )
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

On 6/22/22 11:58, Sagi Grimberg wrote:
> 
> 
> On 6/22/22 12:20, Hannes Reinecke wrote:
>> On 6/22/22 11:09, Sagi Grimberg wrote:
>>>
>>>>>>>> Looks like if I pass a malformed ctrl key to nvme connect I am 
>>>>>>>> able to
>>>>>>>> crash the system:
>>>>>>>
>>>>>>> This was what I used in this:
>>>>>>> $ nvme connect -a 192.168.123.1 -t tcp  -s 8009 -n testnqn1 -S 
>>>>>>> "DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I:" -C 
>>>>>>> "DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
>>>>>>>
>>>>>>> The dhchap_ctrl_key is the offending string...
>>>>>>>
>>>>>> Right. Should be fixed with the attached patch.
>>>>>> Can you check?
>>>>>
>>>>> Yes, that works.
>>>>
>>>> So, to summarize: With this one and the tentative patch I've sent 
>>>> earlier:
>>>>
>>>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>>>> index 53184ac76240..a03f41fa146e 100644
>>>> --- a/drivers/nvme/host/auth.c
>>>> +++ b/drivers/nvme/host/auth.c
>>>> @@ -842,6 +842,10 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, 
>>>> int qid)
>>>>                  dev_warn(ctrl->device, "qid %d: no key\n", qid);
>>>>                  return -ENOKEY;
>>>>          }
>>>> +       if (ctrl->opts->dhchap_ctrl_secret && !ctrl->ctrl_key) {
>>>> +               dev_warn(ctrl->device, "qid %d: invalid ctrl key\n", 
>>>> qid);
>>>> +               return -ENOKEY;
>>>> +       }
>>>>
>>>>          mutex_lock(&ctrl->dhchap_auth_mutex);
>>>>          /* Check if the context is already queued */
>>>>
>>>>
>>>>
>>>> your issues are resolved?
>>>> Just to clarify before I sent another round of patches ...
>>>
>>> No. I don't understand why this patch is needed. As I noted
>>> earlier, when I pass a wrong ctrl key I fail to connect do
>>> to authentication error. Also when I pass a malformed ctrl key.
>>>
>>> So what does this patch fix? Can you give me an example that should
>>> have failed before and only with this patch it fails?
>>>
>> Reasoning is as follows:
>> When an invalid controller key is passed via 
>> 'ctrl->opts->dhchap_ctrl_secret' we'll end up with an empty 
>> 'ctrl->ctrl_key' in nvme_auth_init_ctrl() (which is what caused the 
>> original oops).
>> But the negotiation will still start, and, seeing that 
>> 'ctrl->ctrl_key' is empty, will _not_ attempt controller authentication.
>> But as a controller key is passed from userland we should have 
>> attempted it, and hence an error is in order.
> 
> Yes, I see it now.
> And the patch seems to work.
> 
>>> And for the other issue, please read it again, I think it is related
>>> to nvme-cli and not this patchset.
>>
>> Hmm. Okay, I'll check, and possibly have to create another blktest for 
>> this ...
> 
> Looks like a libnvme fix makes the behavior go away:
> -- 
> diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
> index 53199a29e264..2dd863fb8b4c 100644
> --- a/src/nvme/fabrics.c
> +++ b/src/nvme/fabrics.c
> @@ -596,8 +596,11 @@ int nvmf_add_ctrl(nvme_host_t h, nvme_ctrl_t c,
>                                          nvme_ctrl_get_host_iface(c),
>                                          nvme_ctrl_get_trsvcid(c),
>                                          NULL);
> -               if (fc)
> +               if (fc) {
>                          cfg = merge_config(c, nvme_ctrl_get_config(fc));
> +                       if (fc->dhchap_key)
> +                               nvme_ctrl_set_dhchap_key(c, 
> fc->dhchap_key);
> +               }
>          }
> 
>          nvme_ctrl_set_discovered(c, true);
> -- 
> 
> Looks like when we scan to see an existing controller in the config,
> we find it, but merge_config does not touch the ctrl dhchap_key.
> 
> Maybe it would be better to just add the dhchap_key to the ctrl cfg
> and have merge_config merge it as well? Or we can live with dhchap_key
> merged explicitly?

Hmm. That runs slightly afoul of the merge logic.
'merge_config' will overwrite any value _not_ being the default.
Consequently, if a non-default value is already set it won't be overwritten.
Which means that if the 'cfg' structure already contained a controller 
secret (which could've been used, say, for discovery) we won't overwrite 
it in merge_config().
Hence I fear we have to go with your suggestion.

Will be preparing a pull request.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

