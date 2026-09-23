Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15860C98304
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2A/ofs5ZSSSf98GuBfqQQoULt5z4/wYPrn29uzOPQrA=; b=MTw/0kOcKpUSUjhUoIZ/HgUXFM
	PCQYv/d8qAQa0NlLd7L9c/hMsKHbbBnDvgHICBs1Ofh2crjgeGCOHDONETDTFJf7Mliq16SJpImlY
	ZuZC+fOw8oS0Yi4LhvKE96WETSG7nVZ3mUSWBor8JJDfN/gYsVP4pv2bb+FZqOLFGNYF0r4+PIcZX
	zQD6aCxCbfmBG/QF1CpXI5ykxZZ7dVZ2TwRisNsuElD5NLMvEprbQ/6mwI3to5o8dbb7IiR9+xjX6
	pLy3IvEy08tuTFRc6JEYojv3kkDTKnRwW2O4FJzwAYxNk1VkmGzpe3kkLyvBx5zNQlAz2ybr5h95U
	vfR7LH2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9OzP-00000008kZD-34rv;
	Wed, 23 Sep 2026 15:34:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9OzO-00000008kYz-0N2o
	for linux-nvme@bombadil.infradead.org;
	Wed, 23 Sep 2026 15:34:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=2A/ofs5ZSSSf98GuBfqQQoULt5z4/wYPrn29uzOPQrA=; b=RguCQoDjsrss2vN2YSecnZudv0
	fIRUoAWaf6WYnP1e4L2rxD3knj+7Wi4eLrD5AJjyzN7H0EMwtU1YFygOiHs9M5om+kZxEgnqYyPkw
	ZfqGIomqbda5rXZNkZQcmkj3slFblxU4CoyIYjyNDqIQQZR5G2xoHYQY0e2EuvhWtWX4CskVFCsP3
	sUbjBl4bUZ71S9fKvqt75B/bA77yLjZWVO9onOuO1GueiwX1fboP0YV4/2WmrsaIywE1Xri8NhxTO
	w9e0KbDk9LkVkD4u5ZQ2bXxPHpA40GLb0P2nAP8nG8UYuIYXsjEpTqIqJsEiWqeIGrF/y6XSFmpZ+
	5MP+YIdA==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9OzL-0000000Ewah-0C48
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 15:34:28 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9FCB021B7A;
	Wed, 23 Sep 2026 15:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790177660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2A/ofs5ZSSSf98GuBfqQQoULt5z4/wYPrn29uzOPQrA=;
	b=xvBqs625zGneEtbpjYHSKL2m9N0R9LJOqvEEHLw9Y76+dlEb7oiIK1FeMc7DoglWTWJMrg
	ELNY4JRXBH7C6dDo7+x2LMYWnzEkN+NUTLEWW9PZ7V2EMCur8zt/yTQVwKq1McNqz2eh1m
	jVq4sKR9BYCotTkhebF6R8LmDd/OL20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790177660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2A/ofs5ZSSSf98GuBfqQQoULt5z4/wYPrn29uzOPQrA=;
	b=YoYLU/a1HJeHWp7WHSXOkH6BigqxCYnZ2qnR/0S/JxB0mek22nfswtXBbp3U527OCeZtyA
	fBWXnVOflHP+xACA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MIguxy91;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=t7cNNcxK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790177656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2A/ofs5ZSSSf98GuBfqQQoULt5z4/wYPrn29uzOPQrA=;
	b=MIguxy91LQdP6IhsG98//tvS5dJVOzUf8bH+ykt5ahWcIbNETpnbsAND4U++CCEQ12yBGM
	v+I9cWq18YSgt+drBG+2Ti8PCoF4qQxFTpzCea28d12ND8rD+QNh151/5+1kt70RvYEiou
	Ik4EhvnuIz9wC9VvrwTtx8Z2GzMcL/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790177656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2A/ofs5ZSSSf98GuBfqQQoULt5z4/wYPrn29uzOPQrA=;
	b=t7cNNcxKDnj7sEUK3WltNsc0RPFokO7lca46uiBfgW7YKxfE2C4loMdCdQMXH/wHqoryKZ
	M9HxeRFPSPDUZMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6306134E8;
	Wed, 23 Sep 2026 15:34:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7+eYInfxs2o9MgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 23 Sep 2026 15:34:15 +0000
Message-ID: <d4879e78-2735-4f86-beab-8aa319e9162c@suse.de>
Date: Wed, 23 Sep 2026 17:34:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] nvme: fcloop: Add set_marginal_rport to sysfs
To: Jesse Taube <jtaubepe@redhat.com>
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 John Meneghini <jmeneghi@redhat.com>, Bryan Gurney <bgurney@redhat.com>,
 Chris Leech <cleech@redhat.com>, "Ewan D . Milne" <emilne@redhat.com>,
 shinichiro.kawasaki@wdc.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20260902200547.184734-1-jtaubepe@redhat.com>
 <20260902200547.184734-8-jtaubepe@redhat.com>
 <ab97f32b-31dd-4975-a8b2-b445110ae3a9@suse.de>
 <CADRr4bePoiDnWX_XrMWtQe=1g4Yrw1_dK86EV2k9XZR0HnL+UQ@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CADRr4bePoiDnWX_XrMWtQe=1g4Yrw1_dK86EV2k9XZR0HnL+UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9FCB021B7A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,lwn.net,linuxfoundation.org,kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,hansenpartnership.com,oracle.com,marvell.com,redhat.com,wdc.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_163427_345116_71275193 
X-CRM114-Status: GOOD (  22.81  )
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

On 9/23/26 4:56 PM, Jesse Taube wrote:
> On Mon, Sep 21, 2026 at 10:03 AM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 9/2/26 10:05 PM, Jesse Taube wrote:
>>> To allow testing of multipath failover, add a sysfs attribute to set a
>>> remote port as marginal. This will allow the fcloop LLDD to set the
>>> marginal flag on a remote port, simulating a marginal link.
>>>
>>> Example:
>>> Turn on marginal for a remote port matching wwnn and wwpn:
>>> `echo 'wwnn=0x200000109b5f2956,wwpn=0x100000109b5f2956,marginal=1' >
>>> /sys/class/fcloop/ctl/set_marginal_rport`
>>>
>>> Turn off marginal for a remote port matching wwnn and wwpn:
>>> `echo 'wwnn=0x200000109b5f2956,wwpn=0x100000109b5f2956,marginal=0' >
>>> /sys/class/fcloop/ctl/set_marginal_rport`
>>>
>>> Suggested-by: John Meneghini <jmeneghi@redhat.com>
>>> Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
>>> V10 -> V1:
>>>    - New patch
>>> V1 -> V2:
>>>    - Fix reference count leak in error path
>>> ---
>>>    drivers/nvme/target/fcloop.c | 50 ++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 50 insertions(+)
>>>
>>> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
>>> index b63af3b643a6..9977c2a71bd5 100644
>>> --- a/drivers/nvme/target/fcloop.c
>>> +++ b/drivers/nvme/target/fcloop.c
>>> @@ -6,6 +6,7 @@
>>>    #include <linux/module.h>
>>>    #include <linux/parser.h>
>>>    #include <uapi/scsi/fc/fc_fs.h>
>>> +#include <uapi/scsi/fc/fc_els.h>
>>>
>>>    #include "../host/nvme.h"
>>>    #include "../target/nvmet.h"
>>> @@ -21,6 +22,7 @@ enum {
>>>        NVMF_OPT_FCADDR         = 1 << 3,
>>>        NVMF_OPT_LPWWNN         = 1 << 4,
>>>        NVMF_OPT_LPWWPN         = 1 << 5,
>>> +     NVMF_OPT_MARGINAL       = 1 << 6,
>>>    };
>>>
>>>    struct fcloop_ctrl_options {
>>> @@ -31,6 +33,7 @@ struct fcloop_ctrl_options {
>>>        u32                     fcaddr;
>>>        u64                     lpwwnn;
>>>        u64                     lpwwpn;
>>> +     u32                     marginal;
>>>    };
>>>
>>>    static const match_table_t opt_tokens = {
>>> @@ -40,6 +43,7 @@ static const match_table_t opt_tokens = {
>>>        { NVMF_OPT_FCADDR,      "fcaddr=%x"     },
>>>        { NVMF_OPT_LPWWNN,      "lpwwnn=%s"     },
>>>        { NVMF_OPT_LPWWPN,      "lpwwpn=%s"     },
>>> +     { NVMF_OPT_MARGINAL,    "marginal=%d"   },
>>>        { NVMF_OPT_ERR,         NULL            }
>>>    };
>>>
>>> @@ -120,6 +124,13 @@ fcloop_parse_options(struct fcloop_ctrl_options *opts,
>>>                        }
>>>                        opts->lpwwpn = token64;
>>>                        break;
>>> +             case NVMF_OPT_MARGINAL:
>>> +                     if (match_int(args, &token)) {
>>> +                             ret = -EINVAL;
>>> +                             goto out_free_options;
>>> +                     }
>>> +                     opts->marginal = token;
>>> +                     break;
>>>                default:
>>>                        pr_warn("unknown parameter or missing value '%s'\n", p);
>>>                        ret = -EINVAL;
>>> @@ -199,6 +210,9 @@ fcloop_parse_nm_options(struct device *dev, u64 *nname, u64 *pname,
>>>
>>>    #define TGTPORT_OPTS        (NVMF_OPT_WWNN | NVMF_OPT_WWPN)
>>>
>>> +#define MARGINAL_OPTS        (NVMF_OPT_WWNN | NVMF_OPT_WWPN | \
>>> +                      NVMF_OPT_MARGINAL)
>>> +
>>>
>>>    static DEFINE_SPINLOCK(fcloop_lock);
>>>    static LIST_HEAD(fcloop_lports);
>>> @@ -1663,6 +1677,40 @@ fcloop_set_cmd_drop(struct device *dev, struct device_attribute *attr,
>>>        return count;
>>>    }
>>>
>>> +static ssize_t
>>> +fcloop_set_marginal_rport(struct device *dev, struct device_attribute *attr,
>>> +             const char *buf, size_t count)
>>> +{
>>> +     struct fcloop_nport *nport;
>>> +     struct fcloop_ctrl_options opts = {};
>>> +     unsigned long flags;
>>> +     int ret;
>>> +
>>> +     ret = fcloop_parse_options(&opts, buf);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     /* everything there ? */
>>> +     if ((opts.mask & MARGINAL_OPTS) != MARGINAL_OPTS)
>>> +             return -EINVAL;
>>> +
>>> +     nport = fcloop_nport_lookup(opts.wwnn, opts.wwpn);
>>> +     if (!nport)
>>> +             return -ENOENT;
>>> +
>>> +     spin_lock_irqsave(&fcloop_lock, flags);
>>> +     if (!nport->rport || !nport->rport->remoteport) {
>>> +             spin_unlock_irqrestore(&fcloop_lock, flags);
>>> +             fcloop_nport_put(nport);
>>> +             return -ENOENT;
>>> +     }
>>> +
>>> +     nvme_fc_set_remoteport_fpin(nport->rport->remoteport, opts.marginal);
>>> +     spin_unlock_irqrestore(&fcloop_lock, flags);
>>> +     fcloop_nport_put(nport);
>>> +
>>> +     return count;
>>> +}
>>>
>>>    static DEVICE_ATTR(add_local_port, 0200, NULL, fcloop_create_local_port);
>>>    static DEVICE_ATTR(del_local_port, 0200, NULL, fcloop_delete_local_port);
>>> @@ -1671,6 +1719,7 @@ static DEVICE_ATTR(del_remote_port, 0200, NULL, fcloop_delete_remote_port);
>>>    static DEVICE_ATTR(add_target_port, 0200, NULL, fcloop_create_target_port);
>>>    static DEVICE_ATTR(del_target_port, 0200, NULL, fcloop_delete_target_port);
>>>    static DEVICE_ATTR(set_cmd_drop, 0200, NULL, fcloop_set_cmd_drop);
>>> +static DEVICE_ATTR(set_marginal_rport, 0200, NULL, fcloop_set_marginal_rport);
>>>
>>>    static struct attribute *fcloop_dev_attrs[] = {
>>>        &dev_attr_add_local_port.attr,
>>> @@ -1680,6 +1729,7 @@ static struct attribute *fcloop_dev_attrs[] = {
>>>        &dev_attr_add_target_port.attr,
>>>        &dev_attr_del_target_port.attr,
>>>        &dev_attr_set_cmd_drop.attr,
>>> +     &dev_attr_set_marginal_rport.attr,
>>>        NULL
>>>    };
>>>
>> Please don't make it a fabrics option.
> 
> What do you mean by fabrics option? How should I fix this?
> 
Your patch does two things; one is to modify the parser in 
fcloop_parse_options, and the other is to implement a new
sysfs rport attribute 'set_marginal_rport()'.
My suggestion is to drop the first part; we really should not start off 
with a marginal port, rather only set ports to marginal during runtime.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

