Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72617C021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WT/e1NPqFVPRk0VeexpY3gu2bFX/ah2sTyCgZLZp0Ds=; b=bX9SjKFIDjiaxWeaxIJ5yHkVje
	gTD0JyQokZJHZTNhO6R5rIuiv5wQL+AdLuFo/MLXMdJgZidXXsTy4ZkPTodb0Y5bpZJjJk5Y7DQR0
	tyD1vOKE3fVpcTk0SoQjj/mkHKE28hUyU8xq7Dp2soSE1VNbVpFHm1Q7kFXpwa4AR5Uu+IBg1ZV7w
	VrnS/PPEudsZFtZefZ6CH8byYe6fvkX9IHJJhT2TXX1c+QMh8opz3SLwZDpftsPhttzy+dokeeeXh
	JEF8VdxIHzOZ04pWlwg7p6wpLe0KNYN0PpUJX584Ym233ekbo/SJHhMKXWEFEYeMVLI230skhPSup
	Q+NiXwug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJeR-00000004OGh-1HHG;
	Wed, 26 Feb 2025 15:48:47 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJaj-00000004NRl-0VN9
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 15:44:58 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 23D841F387;
	Wed, 26 Feb 2025 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740584695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WT/e1NPqFVPRk0VeexpY3gu2bFX/ah2sTyCgZLZp0Ds=;
	b=YkCGpM5I9acZohiD9dnyxFl64Ab+0li8mwf7b2KvVBM3/w/f0Z577nF1/U6vroigXHI9Iu
	NgYQhfqnbhQrHt+K4a07w8DF2wS/yJXcptwRqYcn8SBRgJQ37jEoBthT/Zp/1CSqFKpswN
	+LSKgt5zFDI07eUh2eHHTHvtGP/bv50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740584695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WT/e1NPqFVPRk0VeexpY3gu2bFX/ah2sTyCgZLZp0Ds=;
	b=KLEXvqrjK4dGTbjFTELtm2VMerhUVC1+n+Vg9iuvEAcR9oQSRRAKM3xyqksiCHjvva9lW0
	wDlMwmC/O/lo+RCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YkCGpM5I;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KLEXvqrj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740584695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WT/e1NPqFVPRk0VeexpY3gu2bFX/ah2sTyCgZLZp0Ds=;
	b=YkCGpM5I9acZohiD9dnyxFl64Ab+0li8mwf7b2KvVBM3/w/f0Z577nF1/U6vroigXHI9Iu
	NgYQhfqnbhQrHt+K4a07w8DF2wS/yJXcptwRqYcn8SBRgJQ37jEoBthT/Zp/1CSqFKpswN
	+LSKgt5zFDI07eUh2eHHTHvtGP/bv50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740584695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WT/e1NPqFVPRk0VeexpY3gu2bFX/ah2sTyCgZLZp0Ds=;
	b=KLEXvqrjK4dGTbjFTELtm2VMerhUVC1+n+Vg9iuvEAcR9oQSRRAKM3xyqksiCHjvva9lW0
	wDlMwmC/O/lo+RCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0020413A53;
	Wed, 26 Feb 2025 15:44:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xn9bO/Y2v2e0XwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 26 Feb 2025 15:44:54 +0000
Message-ID: <8899bfa5-bd8b-4d34-a149-40f30d12cb1e@suse.cz>
Date: Wed, 26 Feb 2025 16:46:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from
 kmem_cache_destroy()
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Keith Busch <keith.busch@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Jakub Kicinski <kuba@kernel.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 Jann Horn <jannh@google.com>, Mateusz Guzik <mjguzik@gmail.com>,
 linux-nvme@lists.infradead.org, leitao@debian.org
References: <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636> <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73p2lRwKagaoUnP@kbusch-mbp>
 <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
 <Z74Av6tlSOqcfb-q@pc636> <Z74KHyGGMzkhx5f-@pc636>
 <8d7aabb2-2836-4c09-9fc7-8bde271e7f23@suse.cz> <Z78lpfLFvNxjoTNf@pc636>
 <93f03922-3d3a-4204-89c1-90ea4e1fc217@suse.cz> <Z782eoh-d48KXhTn@pc636>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <Z782eoh-d48KXhTn@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 23D841F387
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,joelfernandes.org,joshtriplett.org,linux.com,google.com,goodmis.org,efficios.com,inria.fr,zx2c4.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org,googlegroups.com,lists.infradead.org,debian.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLctujmen6hjyrx8fu4drawbuj)];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_074457_310823_CEC36D6B 
X-CRM114-Status: GOOD (  13.81  )
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

On 2/26/25 4:42 PM, Uladzislau Rezki wrote:
> On Wed, Feb 26, 2025 at 03:36:39PM +0100, Vlastimil Babka wrote:
>> On 2/26/25 3:31 PM, Uladzislau Rezki wrote:
>>> On Wed, Feb 26, 2025 at 11:59:53AM +0100, Vlastimil Babka wrote:
>>>> On 2/25/25 7:21 PM, Uladzislau Rezki wrote:
>>>>>>
>>>>> WQ_MEM_RECLAIM-patch fixes this for me:
>>>>
>>>> Sounds good, can you send a formal patch then?
>>>>
>>> Do you mean both? Test case and fix? I can :)
>>
>> Sure, but only the fix is for stable. Thanks!
>>
> It is taken by Gregg if there is a Fixes tag in the commit.
> What do you mean: the fix is for stable? The current Linus
> tree is not suffering from this?

I just meant the fix should be a Cc: stable, and the testcase not.
mm/ has an exception from "anything with Fixes: can be taken to stable"

> 
> --
> Uladzislau Rezki


