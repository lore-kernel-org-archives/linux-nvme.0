Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D5606A327
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Nov 2026 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ofBbP0GY;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=m+b548ra
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/ObX0z92vMMwlVFIRqUffs3xnTOINmuVmFY1k0W8fVs=; b=ofBbP0GYvXncwm
	ZtLLj3vRxFYyEGacsZncmpidI9/8u/GU+DEFxQ40mffbg4aJlLiw+YeN9XCEuhoDs+IIbXp3yAtBj
	C8v6UhVXFqIWJ0YPaCOs+TQWL4m8qa5433p+v3r5iRQmfjrShsCh5ZDC6c6bgfbbOPWZz4PkEMsHg
	rCDyUu56NIrLko6J4y+v/TnXS4/NquJS1Y4zScbLOM+gB6owiz17/SpC1ONolaN2JUaIcF9LXeByf
	PBq627mN42snO5d91Lz9S6gf4EdZAhAhkW8zHX+uqugb3I+3ky4u+I70mMv/Tj4C3uVwCIU1LC14R
	gOZmXig7WMwOmWr6MJFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSfS6-00000000MQe-14pw;
	Sun, 15 Nov 2026 18:59:46 +0000
Received: from out-122.mta1.migadu.com ([2001:41d0:203:375::7a] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSfS3-00000000MQ3-2a4Q
	for linux-nvme@lists.infradead.org;
	Sun, 15 Nov 2026 18:59:45 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=r3KwoUnK5Cpd0P3vAYLdMdF/mK6lClj/XHu1EZl9IQk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794769181; v=1; x=1795373981;
 b=m+b548raxrJiL5rD83zD7iSPQgSwYvP9WuI3cFiQTKBr3XJHYP/FHz5KmuWZu1gJvkA8UAT4
 vu9H4hYculmihRzuin0ZLl5mZUFsDx75A3Kds86gWoNoOgCYctsPIDwkOf4c8gNX/k8lwDXPHbN
 9+yv061U0MSvBjdwchDItkzg=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 6c594d68444740c8;
	Sun, 15 Nov 2026 18:59:41 +0000
X-Mizu-Trace-ID: 6c594d68444740c8
X-Migadu-Flow: FLOW_OUT
Message-ID: <01eac6bf-8df7-4e7a-8cc6-93e013750bce@linux.dev>
Date: Sun, 15 Nov 2026 18:59:37 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/29] Native SCSI Multipath support
To: Laurence Oberman <loberman@redhat.com>,
 james.bottomley@hansenpartnership.com, mkp@kernel.org
Cc: hare@suse.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, snitzer@kernel.org, jmeneghi@redhat.com,
 bmarzins@redhat.com, dm-devel@lists.linux.dev, hch@lst.de,
 michael.christie@oracle.com
References: <20261108204733.557995-1-john.garry@linux.dev>
 <9b90edc29d5b3be49f5bd0e0ecec5f1701e089bf.camel@redhat.com>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <9b90edc29d5b3be49f5bd0e0ecec5f1701e089bf.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_105943_887628_A783E180 
X-CRM114-Status: GOOD (  17.71  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 20:19, Laurence Oberman wrote:
> 2. ANO paths are ranked the same as AO paths
> 
> With the ALUA state corrected (by writing "activate" to dh_state, or
> with the fix above), I/O still went to active/non-optimized paths.
> scsi_multipath_sdev_init() sets mpath_device->access_state to
> MPATH_STATE_OPTIMIZED and nothing updates it, while
> __mpath_find_path(), mpath_round_robin_path() and
> mpath_queue_depth_path() rank paths by that field. Only
> scsi_mpath_is_optimized()/is_disabled() read sdev->access_state.
> 
> With numa, the first path in dev_list wins for every node, and
> dev_list order follows sd probe completion, so for about a third of
> the LUNs the current path was an ANO path. Example, LUN sdn, reads
> completed per path for a 2000 x 1M O_DIRECT dd (:0/:3 AO, :1/:2 ANO
> at the time):
> 
>    sdn:0 0sdn:1 2000sdn:2 0sdn:3 0
> 
> Every read went through the non-owning controller. From the code, for
> these LUNs the numa recheck of is_optimized() fails on every I/O and
> __mpath_find_path() picks the same ANO path again.
> 
> With the change below (a template callback so the selectors use the
> live state), plus the scsi_dh_alua fix, all 30 LUNs pick an AO
> current path at boot, and on LUN sdl (:0/:2 AO, :1/:3 ANO):
> 
>    numa         2000     0     0     0
>    round-robin  1000     0  1000     0
>    queue-depth 18039     0 13961     0   (8 parallel dd, 64k)
> 
> No I/O reached the ANO paths under any policy. This is a test patch to
> show the problem, not a polished change - feel free to fold it in or
> do it differently.


JFYI, the work which I did for ALUA support a while ago is here:
#https://github.com/johnpgarry/linux/commits/scsi-multipath-v7.3-v7-alua/

I don't think that I shared this previously.

I do notice that it would conflict with your work to do some 
centralising of the ALUA RTPG support.

About the NUMA iopolicy - apart from issues in this series with not 
checking optimised/access_state properly - it does seem less than 
optimal to we only favour one device per NUMA node (when all in same 
optimized + enabled state). NVMe multipath support does the same. I 
suppose that this iopolicy relies on us having one device/path per NUMA 
node.

Thanks,
John

