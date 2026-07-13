Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8246EC44511
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2026 15:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CU2l/l+grvYULNyVB/JOkonr04ETPKXJ4oV6oaYMGmQ=; b=DmnO/3rYQ4vPs2oIkFU7HqRGoY
	O2hgZROuVjwcAcdkDpg1DRjq7MANTfvctGNNnOzA2bF8QmC34GlvoNCMPqli06gxhP35JOAKPV2i6
	IIlaI/IvrMBJ3K3RFxEtMltd3B6QLZN6vSouWf6YAswL3wg5RymnuIPUTlMpzbCno18AMOQgqH2ca
	0u8PtDbuoABVPvW0f4BAihiW4crFv7VkJ9qt3ARP5fuBAdL6UjwZBvTuvYnpijJn4e92JvH1HUvuZ
	2ijEmwRxqS9gIfgCekA/cqq305NAJrecghReCSJa9n8LH29RCSmZtqPNZgboDlWaN/IW/AT1yNq/e
	w7fCRwaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNaW-0000000HZPs-2gT4;
	Thu, 16 Jul 2026 15:01:24 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjHYL-00000009a8G-1Q6R;
	Mon, 13 Jul 2026 14:22:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=CU2l/l+grvYULNyVB/JOkonr04ETPKXJ4oV6oaYMGmQ=; b=h8XqPtmbDkyaTAMKdZypmGVxMv
	wr1dY/YzkXXtoujjPkYPpsRwxcBxWLxK2kxFyyFHtIMbgK5Vw9BILKHrenBWExFbL5cUvQyeFm9xl
	7XlX9oUhul3A7gs2ml/9GqgxIZvNO4/HdytsI2OwTmr8OPKzCdIewVqmomyDxJY2u/umJVGmnNrpU
	Z2aNBPVFaVdmt9IvI/Kk2ud4w4TfiC1cu8olRSPIeDcGzD8EZvNDuz2dmD2Bb3t0ixtAtilZ+YPM9
	QRbEa5VWkhgFWS+lzFFDq91iyxadTtOJOWikbXNW31moxbo6KsZ0Nk4UoRJIcoqIrtTdv0+soBcxK
	6WVigOwQ==;
Received: from flow-b8-smtp.messagingengine.com ([202.12.124.143])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wjHYH-0000000Bhw9-2vha;
	Mon, 13 Jul 2026 14:22:36 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id D2F14130008E;
	Mon, 13 Jul 2026 10:22:28 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jul 2026 10:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783952548;
	 x=1783959748; bh=CU2l/l+grvYULNyVB/JOkonr04ETPKXJ4oV6oaYMGmQ=; b=
	Lh7lF+Y9bDgUjn6EOGYYC29ZSbRGGbWTEqBYICxtaVgzMoCUsRMW5j0AJFe9zZKf
	QYjcpqqPLjIxsGkMxlz6Wm48qLtiFtm3jSNPAa9VR1yldqnV8iYJZuV+ka5Zryiz
	mm+PJfh3+JM6oGIon0b8xg3rB89vMHUN73yDQv9UjEeZr/weAajlVU7Bi35h68oK
	2NJ/DA/BwI815lmGCdYT4uCm0hsiCepQIqWBrk+GcqJq9n3lwp2ndWsdhBIMemQS
	WBCyhW7n9x+WVZUMmVqwZJ/EMt2ehyGJlhXnUrEyHoCf4VgAlbLX6mWtU3301JgR
	ndHXFc7fnZXg0Q8zRjq8Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783952548; x=
	1783959748; bh=CU2l/l+grvYULNyVB/JOkonr04ETPKXJ4oV6oaYMGmQ=; b=g
	YlB95DRbFskSS7BaRoK6Dal5i9lQFRrZabf1oih/dW8jvbLgbhdX+9D83VQlKWvy
	zhHpIKUJMXZNFUz+8BMD0BqBrDIkGVx8YbiacjAFczSoS6M2bL+Q8Fnpu54qNrGe
	FEkT/W2VQQwIeTloeEqCL6NAA+JW+eAEFKtaKQkRRtpakH39fdCM/BqpHQSMgw1T
	LJsHerjuy3xoEcF0wm6a8qlJocVQ+LpTdy4CSm6vI+kVLlzWewL7d0gg3QyP9cur
	L/jMUQ44LxHvWtRpzZBLtTTVIj+gZVP5WTG9iULb/DEsgqCumG0JpDHmWMOEx8lV
	MzlD0OJeC/wVVkAaz4f0w==
X-ME-Sender: <xms:ovRUav7TlZN-a2_unM3mLC-HWPhnAclyD_NbFNPheekrnQs8buleXA>
    <xme:ovRUavtK-ABrXEMyRUZgLQ9sqK-1WYueT1PLnWIxW7DlLf6QXdAKL_S8i95xZsOfq
    E2wxHybxcyMrHz-zKjhKXarvGVoLhf4u1lIu1B4mdO6bIAZbO-6>
X-ME-Proxy-Cause: dmFkZTGkfromSsp3G4rSLONAnUYo47mIdjtZXM5DmI/mzu4ZZV/RAeMAuRK8H7+e4o2JDs
    OiZX31EHOqiT2sLAdD+Osn17l+GzdDLgqcJZopQmE1PWsA1geojywiJqDhFZUZZIB4zabR
    O3JlgG3Ef4E+wyHvFQbhgfxW6D2NxaNwqYL3Xa6ecuMGHGC3f5oGdP1/NAMK9D5Sk4iKSr
    xrMiV29NXuU8QrlZ840MTbYz8uz6GfaCpnWxc3dP25hhym7Wh0bA64ROW490WcRrZkRrNk
    2QJW9zJmfuWPGuFscrooblh2nJcbSl2nf4MHCUcAMxGxCDXO4Fqzh0ddDq7R7XXni94jKd
    JcpVjdsDo7SkAGfOW1QDESPkp+aTIeHWia8lnTMGiZPuHxgei3y/8PiGHnDrvoZ9HvoWTr
    AVFVQr2SC3lZsoXwY3E7CssI9oOGiRsso0Dm6VkYHffeNMz6QoNzQYG5XivGnnitAfHeey
    lV+bSWCs2mphE5N09KycIixzLP6/P8W3g8E6+pkScoFIXNq0pp4mScFyVrni4ziIswLgRA
    t4AWYlEvD2SRXz1zJrHgqUpIcHNE6fTul3Pka+NkRru3x+44bFia6TOHLb+0COfcEnK6Wt
    j6HLZZJIorGMDVUXd2hWIMoPQWmSUoJmP73VOfwvUA85gLVYalKq3cL6ZEhA
X-ME-Proxy: <xmx:ovRUao5OTOdoCI1NbU5ncXXeImi1FeLyUTR4J04nC2mO9aJTVBg01A>
    <xmx:ovRUagdHQT83vSsgCnhq2L2fU4HwEtJEydDYpBEl6Rwv4C25KHcApA>
    <xmx:ovRUakq0mJL1SEZy_6gXRApBLmgd6AirY4GePNNrtyg5pqO7X6OJ_Q>
    <xmx:ovRUavMgbAoHHNwrxlki6UdqL5Zv93FnXa-n7kug2Hqw7WmXxf3IiA>
    <xmx:pPRUauxGo7S8G31bNaPEH8I8UNIbDAWogLs0r42oreenpO1SWE09kUUA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DC870182007E; Mon, 13 Jul 2026 10:22:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: ARmmoW1aQeCk
Date: Mon, 13 Jul 2026 16:22:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Fernando Fernandez Mancera" <fmancera@suse.de>,
 Netdev <netdev@vger.kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "David Ahern" <dsahern@kernel.org>, "Simon Horman" <horms@kernel.org>, "Ido Schimmel" <idosch@nvidia.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Leon Romanovsky" <leon@kernel.org>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "Anthony L Nguyen" <anthony.l.nguyen@intel.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, "Elad Nachman" <enachman@marvell.com>, "Saeed Mahameed" <saeedm@nvidia.com>, "Tariq Toukan" <tariqt@nvidia.com>, "Mark Bloch" <mbloch@nvidia.com>, "Petr Machata" <petrm@nvidia.com>, "Edward Cree" <ecree.xilinx@gmail.com>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>, "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Arend van Spriel" <arend.vanspriel@broadcom.com>, "Miri Korenblit" <miriam.rachel.korenblit@intel.com>, "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, "Chaitanya Kulkarni" <kch@nvidia.com>, "Saurav Kashyap" <skashyap@marvell.com>, "Javed Hasan" <jhasan@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, "Nilesh Javali" <njavali@marvell.com>, "Manish Rangankar" <mrangankar@marvell.com>, "Varun Prakash" <varun@chelsio.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "David Howells" <dhowells@redhat.com>, "Marc Dionne" <marc.dionne@auristor.com>, "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>, "Marek Lindner" <marek.lindner@mailbox.org>, "Simon Wunderlich" <sw@simonwunderlich.de>, "Antonio Quartulli" <antonio@mandelbit.com>, "Sven Eckelmann" <sven@narfation.org>, "Nikolay Aleksandrov" <razor@blackwall.org>, "Pablo Neira Ayuso" <pablo@netfilter.org>, "Florian Westphal" <fw@strlen.de>, "Phil Sutter" <phil@nwl.cc>, "Johannes Berg" <johannes@sipsolutions.net>, "Matthieu Baerts" <matttbe@kernel.org>, "Mat Martineau" <martineau@kernel.org>, "Geliang Tang" <geliang@kernel.org>, "Julian Anastasov" <ja@ssi.bg>, "Aaron Conole" <aconole@redhat.com>, "Eelco Chaudron" <echaudro@redhat.com>, "Ilya Maximets" <i.maximets@ovn.org>, "Allison Henderson" <achender@kernel.org>, "Jamal Hadi Salim" <jhs@mojatatu.com>, "Jiri Pirko" <jiri@resnulli.us>, "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>, "Xin Long" <lucien.xin@gmail.com>, "D. Wythe" <alibuda@linux.alibaba.com>, "Dust Li" <dust.li@linux.alibaba.com>, "Sidraya Jayagond" <sidraya@linux.ibm.com>, "Wenjia Zhang" <wenjia@linux.ibm.com>, "Mahanta Jambigi" <mjambigi@linux.ibm.com>, "Tony Lu" <tonylu@linux.alibaba.com>, "Wen Gu" <guwen@linux.alibaba.com>, "Jon Maloy" <jmaloy@redhat.com>, "Steffen Klassert" <steffen.klassert@secunet.com>, "Herbert Xu" <herbert@gondor.apana.org.au>, "Vikas Gupta" <vikas.gupta@broadcom.com>, "Rajashekar Hudumula" <rajashekar.hudumula@broadcom.com>, "Justin Chen" <justin.chen@broadcom.com>, "Bhargava Marreddy" <bhargava.marreddy@broadcom.com>, "Nicolai Buchwitz" <nb@tipi-net.de>, "Florian Fainelli" <florian.fainelli@broadcom.com>, "Heiner Kallweit" <hkallweit1@gmail.com>, "Krzysztof Kozlowski" <krzk@kernel.org>, "Russell King" <rmk+kernel@armlinux.org.uk>, "Yao Zi" <me@ziyao.cc>, "Yanteng Si" <siyanteng@cqsoftware.com.cn>, "Maxime Chevallier" <maxime.chevallier@bootlin.com>, "Julian Braha" <julianbraha@gmail.com>, "Joey Lu" <a0987203069@gmail.com>, "Shangjuan Wei" <weishangjuan@eswincomputing.com>, "Chen-Yu Tsai" <wens@kernel.org>, "Inochi Amaoto" <inochiama@gmail.com>, "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>, "Qingfang Deng" <qingfang.deng@linux.dev>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Eric Biggers" <ebiggers@kernel.org>,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>, "Ard Biesheuvel" <ardb@kernel.org>, "Dmitry Safonov" <0x7f454c46@gmail.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "Alyssa Ross" <hi@alyssa.is>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>, linux-net-drivers@amd.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, dev@openvswitch.org, rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org, "open list:TIPC NETWORK LAYER" <tipc-discussion@lists.sourceforge.net>
Message-Id: <713178ff-0fb2-4f1b-90bc-9841cd42c20e@app.fastmail.com>
In-Reply-To: <2256daf4-d03c-4a57-9d72-7a388d823f18@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
 <20260712013941.4570-2-fmancera@suse.de>
 <12ffac6a-649a-4e4a-8d12-0b48171e1d95@app.fastmail.com>
 <2256daf4-d03c-4a57-9d72-7a388d823f18@suse.de>
Subject: Re: [PATCH 01/13 RFC net-next] net: ipv4: introduce CONFIG_IPV4 to decouple
 the IPv4 stack
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_152234_506673_C9AEBD8A 
X-CRM114-Status: GOOD (  19.34  )
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:01:23 -0700
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

On Mon, Jul 13, 2026, at 16:00, Fernando Fernandez Mancera wrote:
> On 7/12/26 1:01 PM, Arnd Bergmann wrote:
>> On Sun, Jul 12, 2026, at 03:38, Fernando Fernandez Mancera wrote:
>>> Historically, the IPv4 protocol has been linked to the core INET
>>> subsystem. Because shared infrastructure like the TCP/UDP engine,
>>> routing or INET hashtables live inside net/ipv4/, it has been impossible
>>> to compile a kernel with only IPv6 support.
>>>
>>> This patch introduces the CONFIG_IPV4 Kconfig symbol, which is set to
>>> 'def_bool y' for now. This does not allow to completely disable the
>>> IPv4 stack yet but it lays the necessary build-system work for that
>>> goal.
>> 
>> I expect this will cause additional (trivial) build regression in the
>> next step when randconfig builds run into obscure corner cases, either
>> with INET=y IPV4=n IPV6=y or with INET=y IPV4=n IPV6=n.
>> 
>> I can probably give your patch (with IPV4 visible or disabled) an
>> early go on the randconfig tree to find these more quickly.
>> If I run into regressions, should I just add more 'depends on IPV4',
>> or do you have other plans?
>> 
>
> Yes, I have a job running randconfig and verifying nothing breaks. If 
> something breaks and it isn't core networking stack I would just make 
> the Kconfig symbol depend on IPv4.
>
> Then later we will have more time to write a dedicate patch so it does 
> not depend on IPv4.

Ok

>> Should we have some logic to ensure that at least one of IPV4 or
>> IPV6 is enabled? I think this would work
>> 
>> config IPV4
>>        bool "The IPv4 protocol" if IPV6
>>        default INET
>> 
>> which only allows turning IPV4 off if IPV6 has enabled.
>> 
>
> I do wonder, should we? I mean, I didn't try it off but I don't see why 
> we should not allow a pure L2 system..

I expected a pure L2 system to be CONFIG_ETHERNET=y CONFIG_INET=n.

Which user-visible parts of CONFIG_INET would you want keep working
when both v4 and v6 are disabled?

     Arnd

