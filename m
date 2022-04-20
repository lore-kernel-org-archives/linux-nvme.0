Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8D5C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nA0tAob8oLzoAYhY00P1VHQTJ6UPeVSTX8EO5n6n9rc=; b=AAiGa1snRoy98I6SHGNNZLNpQD
	wLoc4vSqHKoE46RIA1ynoLBr9znfdG0PcuTNpfPPHBw0IP82yREuZABMmTCmDEhj1ZDJAtGhMIqSb
	5TCktuSXL56RzyCXZucq6d5g83JRIOoF98iqL56z9JflfgcVz5mmuLVGxhLZU04uxQScdL4qEEUbi
	XL4vHboTy+hUuoP3t2feL+Qf7ebHrgQF730OyL+6bDtvheo74daJUmVXUEtq72CYBnaMw6glgXimQ
	AbNNnnyFbP23HkXAWc3Khoqv+pHgbjz4bbPFzHl7eXiB6EHAsKapcmWN0kkz1hmKkA8BFjdAXgVXV
	q/CKoQaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh7b5-008bAN-8u; Wed, 20 Apr 2022 10:30:07 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh7b1-008b8H-Ue
 for linux-nvme@lists.infradead.org; Wed, 20 Apr 2022 10:30:05 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 207A31F74F;
 Wed, 20 Apr 2022 10:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1650450600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nA0tAob8oLzoAYhY00P1VHQTJ6UPeVSTX8EO5n6n9rc=;
 b=p3J+dwBeQV6fkeKfAe40bgqvHHWqEP4acOJGAPuFSq9diseE+0s5wnKk0Wk2+U3SFF58q9
 cnIhTm9Ea91YzPoWoAaoL5QJSAe3KDwAFx3KqNmV44miKjcSYSyoWe8IiWkQiEbvhbjx/a
 erNNux1itpwuQhQUBCRvOlgenEZ5lhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1650450600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nA0tAob8oLzoAYhY00P1VHQTJ6UPeVSTX8EO5n6n9rc=;
 b=P4SBrjPQgJ17xEDduYgvN2k427GkQlMi1qt2sJFhQrQXG8dUz3iS/NQITLlfBu0tCEy4xD
 oHOIoPmbH+2TmVDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E622813AD5;
 Wed, 20 Apr 2022 10:29:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DSQyN6fgX2KcLAAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 20 Apr 2022 10:29:59 +0000
Message-ID: <6dea1904-f0df-4f58-fdf2-701396ecfa3c@suse.de>
Date: Wed, 20 Apr 2022 12:29:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: can't run nvme-mp blktests
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org> <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
 <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
 <YlkAlHe6LloUAzzN@infradead.org>
 <587c14e7-2b7e-74ac-377b-6faafcb829e4@nvidia.com>
 <4c2f1a15-8d65-b234-a99f-354b4cbeef54@acm.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <4c2f1a15-8d65-b234-a99f-354b4cbeef54@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220420_033004_195709_3459B63E 
X-CRM114-Status: GOOD (  10.79  )
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

On 4/15/22 20:06, Bart Van Assche wrote:
> On 4/14/22 22:58, Chaitanya Kulkarni wrote:
>> If it doesn't add a new test coverage in the blktest framework
>> then please remove.
> 
> cd blktests && git grep -nH dev/nvme-fabrics
> tests/nvmeof-mp/rc:94:    [ -c /dev/nvme-fabrics ] &&
> tests/nvmeof-mp/rc:101:                    echo -n "$loginparams" > 
> /dev/nvme-fabrics
> tests/nvmeof-mp/rc:161:    if [ ! -c /dev/nvme-fabrics ]; then
> tests/nvmeof-mp/rc:162:        echo "Error:  /dev/nvme-fabrics not 
> available"
> 
> Does this mean that there are no other tests in the blktests framework that
> test NVMeOF and hence that it is useful to keep these tests?
> 

# git grep _nvme_connect_subsys
tests/nvme/003: _nvme_connect_subsys "${nvme_trtype}" 
nqn.2014-08.org.nvmexpress.discovery
tests/nvme/004: _nvme_connect_subsys "${nvme_trtype}" blktests-subsystem-1
tests/nvme/005: _nvme_connect_subsys "${nvme_trtype}" blktests-subsystem-1
tests/nvme/008: _nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
tests/nvme/009: _nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
tests/nvme/010: _nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
tests/nvme/011: _nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
tests/nvme/012: _nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
tests/nvme/013: _nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
tests/nvme/014: _nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
tests/nvme/015: _nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
tests/nvme/018: _nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
tests/nvme/019: _nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
tests/nvme/020: _nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
tests/nvme/021: _nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
[ .. ]

So: no, it just means you've been using the wrong filter.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

