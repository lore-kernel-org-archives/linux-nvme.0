Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070F3C5475B
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Mar 2024 19:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mtZDy6PRQwWwoK1IuHrBHawVwKLFNOjuutTjQ1zLGII=; b=Z+MXq2i5+NljbVB5JWUIbt5t7L
	qmT1vkDLFoO9Qpzfw+A5MlTGKugOrSo+SqJyZpiFMAaCGFJpr0/oSVmDG0RZzQrZd3H0a0TM1pf50
	pZY5kz54Ns1or7cm0jky+uJJGspxIo54BYyRffNnMbu8ULDUwTcWMUgXkKmVc2riDENafuUZxT0L0
	CLM+9sX5XN6qugF8OGwGxVQLZZwvi05JLhmI58I7PefuCbDeRvOkqdQKOj+bwCz0NWvTcku+RCBiB
	EK88DjkTP7dqxKW4/IRyAGwByWmlCe5+ywH9IEUchmrv52SWJ5qo+vOLpUOei3Gc8Zm2HAAZMr/aa
	3Z7wN2iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjlKb-00000002wEM-4AUC;
	Mon, 11 Mar 2024 19:29:05 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjlKZ-00000002wCe-1AYq
	for linux-nvme@lists.infradead.org;
	Mon, 11 Mar 2024 19:29:04 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C932C34FD2;
	Mon, 11 Mar 2024 19:28:59 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E16013695;
	Mon, 11 Mar 2024 19:28:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0nXBHHtb72XkTQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 11 Mar 2024 19:28:59 +0000
Message-ID: <14c5a294-e68f-441f-8606-31cfb67670b7@suse.de>
Date: Mon, 11 Mar 2024 20:28:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] nvme-fabrics: introduce ref counting for
 nvmf_ctrl_options
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-4-dwagner@suse.de>
 <342cf4cf-ad14-4fd0-bcab-fe5fcecf4c0a@grimberg.me>
 <3xjjwq56sldxrr3dmcxmzhqjebctrowmfpr3istfqmnitlvpv4@mzjixl3jjnbi>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3xjjwq56sldxrr3dmcxmzhqjebctrowmfpr3istfqmnitlvpv4@mzjixl3jjnbi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: C932C34FD2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_122903_493101_2516D980 
X-CRM114-Status: GOOD (  23.52  )
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

On 3/11/24 18:36, Daniel Wagner wrote:
> On Thu, Mar 07, 2024 at 12:27:43PM +0200, Sagi Grimberg wrote:
>> Why do we need a refcount for an object that has the same exact lifetime
>> as the ctrl itself? It just feels like unneeded complication.
> 
> My claim the UAF is also possible with the current code is not correct.
> Or at least not easy to reproduce. I've re-tested a lot and I couldn't
> reproduce it.
> 
> Though, the UAF is very simple to reproduce with the sync connect patch
> applied (nvme-fc: wait for initial connect attempt to finish) together
> with Hannes' patch (nvme: authentication error are always
> non-retryable):
> 
> In this case, the initial connect fails and the resources are removed,
> while we are waiting in
> 
> +       if (!opts->connect_async) {
> +               enum nvme_ctrl_state state;
> +
> +               wait_for_completion(&ctrl->connect_completion);
> +               state = nvme_ctrl_state(&ctrl->ctrl);
> +               nvme_fc_ctrl_put(ctrl);
> +
> +               if (state != NVME_CTRL_LIVE) {
> +                       /* Cleanup is handled by the connect state machine */
> +                       return ERR_PTR(-EIO);
> +               }
> +       }
> 
> This opens up the race window. While we are waiting here for the
> completion, the ctrl entry in sysfs is still reachable. Unfortunately,
> we also fire an uevent which starts another instance of nvme-cli. And
> the new instance of nvme-cli iterates over sysfs and reads the already
> freed options object.
> 
Curiously enough, I had been digging into better error reporting for 
nvme-fabrics. And the one thing I came up with is to make the controller
_options_ as a private pointer to seq_file.
With that we can allocate and initialize the options during open(),
and then have write() do the parsing and calling create_ctrl() as usual.
But read() would then always have access to the option structure, and
we can use this structure to pass any errors. EG parsing errors could
be reported by an 'err_mask' field and so on.

That would allow us to report errors back to nvme-cli, and,
incidentally, also require reference counting.
Two stones with a bird and all that.

Patch is in testing, and I'll be posting it once I get confirmation.


Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


