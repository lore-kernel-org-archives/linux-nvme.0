Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A70CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 10:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:To:Cc:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FKCKMG+a+OeQMu/rgdstrBjlbt9n1Xntur7XQEFNp04=; b=YwlPvMn8kO4X3MU4jH9IY4arDb
	nMH/GZYZxZL7meF823ywvpujrYcO113crEITQSB/qsiMYAmiJPuywuF3wIWnmPvkEnYqczF5iiUO2
	/mug0PYQWGCjNrVDVSbiHlrn56ExEQG+NlypVyf+JnkASdTxuq9qenT8QL2/fu/FHU7TM6xh9xzKP
	mStxfwoy6nK68GdbDYSpgdSbkzq8WR/84h40jVvpxB2iu5fIHaMC3GdQsis0BCuuhlbTRK3piCZJZ
	+7Z1WCBDo5/EfFmTKxp2deNOSvcBoj0JIDvLj0DAzT+knpWO6GbmSprfUUajFxpFdX3fFv0fpp96r
	Y6/qvHmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntRPf-007ZWw-Pz; Tue, 24 May 2022 10:05:15 +0000
Received: from relay11.mail.gandi.net ([2001:4b98:dc4:8::231])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntRPb-007ZUP-Ta
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 10:05:14 +0000
Received: (Authenticated sender: i.maximets@ovn.org)
 by mail.gandi.net (Postfix) with ESMTPSA id 83B6D100011;
 Tue, 24 May 2022 10:05:02 +0000 (UTC)
Message-ID: <457ccb80-d41d-ff95-1edc-751741465416@ovn.org>
Date: Tue, 24 May 2022 12:05:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc: dev@openvswitch.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 borisp@nvidia.com, netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>,
 simo@redhat.com, linux-fsdevel@vger.kernel.org, ak@tempesta-tech.com,
 i.maximets@ovn.org
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Benjamin Coddington <bcodding@redhat.com>
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030059051.5073.16723746870370826608.stgit@oracle-102.nfsv4.dev>
 <20220425101459.15484d17@kernel.org>
 <66077b73-c1a4-d2ae-c8e4-3e19e9053171@suse.de>
 <1fca2eda-83e4-fe39-13c8-0e5e7553689b@grimberg.me>
 <20220426080247.19bbb64e@kernel.org>
 <40bc060f-f359-081d-9ba7-fae531cf2cd6@suse.de>
 <20220426170334.3781cd0e@kernel.org>
 <23f497ab-08e3-3a25-26d9-56d94ee92cde@suse.de>
 <20220428063009.0a63a7f9@kernel.org>
 <be7e3c4b-8bb5-e818-1402-ac24cbbcb38c@suse.de>
 <E2BF9CFF-9361-400B-BDEE-CF5E0AFDCA63@redhat.com>
 <20220428140856.61e53533@kernel.org>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [ovs-dev] [PATCH RFC 4/5] net/tls: Add support for PF_TLSH (a TLS
 handshake listener)
In-Reply-To: <20220428140856.61e53533@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_030512_313048_5A6544C9 
X-CRM114-Status: GOOD (  29.26  )
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

On 4/28/22 23:08, Jakub Kicinski wrote:
> On Thu, 28 Apr 2022 10:09:17 -0400 Benjamin Coddington wrote:
>>> Noob reply: wish I knew.  (I somewhat hoped _you_ would've been able to
>>> tell me.)
>>>
>>> Thing is, the only method I could think of for fd passing is the POSIX fd
>>> passing via unix_attach_fds()/unix_detach_fds().  But that's AF_UNIX,
>>> which really is designed for process-to-process communication, not
>>> process-to-kernel.  So you probably have to move a similar logic over to
>>> AF_NETLINK. And design a new interface on how fds should be passed over
>>> AF_NETLINK.
>>>
>>> But then you have to face the issue that AF_NELINK is essentially UDP, and
>>> you have _no_ idea if and how many processes do listen on the other end.
>>> Thing is, you (as the sender) have to copy the fd over to the receiving
>>> process, so you'd better _hope_ there is a receiving process.  Not to
>>> mention that there might be several processes listening in...
> 
> Sort of. I double checked the netlink upcall implementations we have,
> they work by user space entity "registering" their netlink address
> (portid) at startup. Kernel then directs the upcalls to that address.
> But AFAICT there's currently no way for the netlink "server" to see
> when a "client" goes away, which makes me slightly uneasy about using
> such schemes for security related stuff. The user agent may crash and
> something else could grab the same address, I think.
> 
> Let me CC OvS who uses it the most, perhaps I'm missing a trick.

I don't think there are any tricks.  From what I see OVS creates
several netlink sockets, connects them to the kernel (nl_pid = 0)
and obtains their nl_pid's from the kernel.
These pids are either just a task_tgid_vnr() or a random negative
value from the [S32_MIN, -4096] range.  After that OVS "registers"
those pids in the openvswitch kernel module.  That just means sending
an array of integers to the kernel.  Kernel will later use these
integer pids to find the socket and send data to the userspace.

openvswitch module inside the kernel has no way to detect that
socket with a certain pid no longer exists.  So, it will continue
to try to find the socket and send, even if the user-space process
is dead.

So, if you can find a way to reliably create a process with the
same task_tgid or trick the randomizer inside the netlink_autobind(),
you can start receiving upcalls from the kernel in a new process,
IIUC.  Also, netlink_bind() allows to just specify the nl_pid
for listening sockets.  That might be another way.

> 
> My thinking was to use the netlink attribute format (just to reuse the
> helpers and parsing, but we can invent a new TLV format if needed) but
> create a new socket type specifically for upcalls.
> 
>>> And that's something I _definitely_ don't feel comfortable with without
>>> guidance from the networking folks, so I didn't pursue it further and we
>>> went with the 'accept()' mechanism Chuck implemented.
>>>
>>> I'm open to suggestions, though.  
>>
>> EXPORT_SYMBOL(receive_fd) would allow interesting implementations.
>>
>> The kernel keyring facilities have a good API for creating various key_types
>> which are able to perform work such as this from userspace contexts.
>>
>> I have a working prototype for a keyring key instantiation which allows a
>> userspace process to install a kernel fd on its file table.  The problem
>> here is how to match/route such fd passing to appropriate processes in
>> appropriate namespaces.  I think this problem is shared by all
>> kernel-to-userspace upcalls, which I hope we can discuss at LSF/MM.
> 
> Almost made me wish I was coming to LFS/MM :)
> 
>> I don't think kernel fds are very special as compared to userspace fds.
> _______________________________________________
> dev mailing list
> dev@openvswitch.org
> https://mail.openvswitch.org/mailman/listinfo/ovs-dev
> 


