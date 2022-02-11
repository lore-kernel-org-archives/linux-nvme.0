Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EF6C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Feb 2022 09:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9h7yYkYclc9Qn1cRn5ZgyrK0tbRbxTrz4KYJ5WyCOvU=; b=XIVub/GMdhYfmIGEpg3p7R88x0
	ZPJsPLa5Ii83DTCv0KkKCzHunPONIrIRoPk7YrIQ8Bp06z9JLS6OJxrDsoyf9bNNgkIH6dhWbnAwv
	3EPKYs6xJUOL2TZiEzAG12/jkT6XCQBhaCC2JXQonRsqYjRApAopDB3TBI3i6tsHJyCzPo6PNNy3y
	/AcMv8JD2cdoj3cR7jDBRnYri8/HMeKccT964URV/Uf7g9Dl/eY7jFl9nrkVWtPV44soBBYueNd+X
	PkBqhvM/JkVm53KHkHGhgejqlRxGT5v33EmgkO9z8XVcnyRB4uIFiMzJTpehVxzbFOdWQx9x3tAlx
	EaHwkM7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIS7g-006KIk-0H; Fri, 11 Feb 2022 09:21:48 +0000
Received: from forward500o.mail.yandex.net ([37.140.190.195])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIS7b-006KIJ-0c
 for linux-nvme@lists.infradead.org; Fri, 11 Feb 2022 09:21:46 +0000
Received: from sas1-a42983ef201b.qloud-c.yandex.net
 (sas1-a42983ef201b.qloud-c.yandex.net
 [IPv6:2a02:6b8:c08:b681:0:640:a429:83ef])
 by forward500o.mail.yandex.net (Yandex) with ESMTP id ECD48941E61;
 Fri, 11 Feb 2022 12:21:37 +0300 (MSK)
Received: from sas8-b61c542d7279.qloud-c.yandex.net
 (sas8-b61c542d7279.qloud-c.yandex.net [2a02:6b8:c1b:2912:0:640:b61c:542d])
 by sas1-a42983ef201b.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 T9M6ts7wkN-Lbcmg3Ln; Fri, 11 Feb 2022 12:21:37 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1644571297; bh=9h7yYkYclc9Qn1cRn5ZgyrK0tbRbxTrz4KYJ5WyCOvU=;
 h=In-Reply-To:From:Subject:References:Date:Message-ID:To;
 b=wAG4mz7IOjJQxmYut1S7GVz6ki8PGFL6WOqHWndCCd/gEbPNJ3x+wL45QGafBo5Hd
 bi09I1YJDhbQmz0FyuOJnWCfEPuuRzDClfmPPR8UpUSBN4dHxi0U+PN7GOZrUGYeez
 uJp/QjGivfjpe7xifTRHncrFG9TofV2tEk6f1jb4=
Authentication-Results: sas1-a42983ef201b.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by sas8-b61c542d7279.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id nlR9KlKRxc-LaHqax6p; Fri, 11 Feb 2022 12:21:36 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Message-ID: <3de626e3-4d03-50a8-9bd2-c974227add02@yandex.ru>
Date: Fri, 11 Feb 2022 12:21:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: NVMe over Fabrics host: behavior on presence of ANA Group in
 "change" state
Content-Language: en-US
To: linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Knight, Frederick" <Frederick.Knight@netapp.com>
References: <3fec0f6d-508c-c783-1779-a00e43fa2821@yandex.ru>
 <9a765265-0200-0eea-872f-780c4dbb69b8@grimberg.me>
 <02375891-2f92-c3d9-8a55-019b84c14c1c@yandex.ru>
 <205b91c3-4da1-744d-3d06-ccfdf2b93cff@grimberg.me>
 <5b5cfff7-6c07-0cb1-491a-0fa3d13c2cbd@yandex.ru>
 <fd8600bd-aa73-82f7-3ca7-ed7f766f1568@grimberg.me>
 <DM8PR06MB770480F38397C8FE8D4D0F22F1309@DM8PR06MB7704.namprd06.prod.outlook.com>
From: Alex Talker <alextalker@yandex.ru>
In-Reply-To: <DM8PR06MB770480F38397C8FE8D4D0F22F1309@DM8PR06MB7704.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220211_012143_640998_D3374F41 
X-CRM114-Status: GOOD (  29.86  )
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

 > [FK> ] I think I'm missing a bunch of context here. What is the
 > original question? I take a stab at some assumptions: What is an
 > empty ANA group? That is an ANA Group with NO NSIDs associated with
 > that group. Meaning the "Number of NSID Values" field is cleared to
 > '0h' in the ANA Group Descriptor. That descriptor can be used to
 > update some host internal state information related to that ANA
 > group, but it has no impact on any I/O because there can be no I/O
 > (since there are no NSID values). So I'm not sure where that is
 > going (because RGO=1 also can return ANA Groups that have state, but
 > no attached namespaces (it's a way to get group state without any
 > NSID inventory requirements)).

That's exactly right, "nnsids=0" case. I/O is not a problem for such a 
group, for sure.
I suppose the main argument we're having here is that when such a group 
has a "change" ANA state,
the host("nvme-core" module) starts a timer for ANATT which upon 
expiration resets the controller.
Now, I do not disagree that having such a group is "ugly" but rather 
argue that ANATT-related functionality could be only invoked for 
"nnsids>0" case,
since only then there's a relation between "change" state and a 
namespace via "ANAGRPID".

My approach for assigning ANA groups to namespaces involves and idea 
that on one node(i.e. "system") casually a namespace has the same state 
on every port,
since it's more likely that access state of the namespace would change, 
rather than what's it accessed through (the port),
so I simply pre-allocate 5 ANA groups per 5 possible at the moment ANA 
states on each port and then change "ANAGRPID" of a namespace to 
transition it from one state to another.
While it is perfectly possible as highlighter earlier to transition 
bypassing "change" state,
it is still preferable in my opinion in situations when the final state 
is not known "a priori",
and thus works as a graceful guard from host's I/O. This is why I opt to 
pre-allocate one for this state too,
however on modern versions of popular distributions that causes the 
reset issue described before,
which might have undetermined impact on my I/O in progress.

Thus, I find starting the ANATT timer redundant when "nnsids=0".
I think the only users such a change might affect if someone uses this 
as a dirty hack to reset controller on host(when that would be helpful 
tho?).
Otherwise, I have prepared & checked on the mainline a simple(+2 lines, 
-2 lines) patch that fixes this behavior,
so I might sent it if it's preferable to have this discussion around an 
actual change.

 > Now this treads into the TP 4108 space. There is currently no way to
 > report anything that impacts "only one namespace at a time". ANY
 > report of a change (AEN) for any namespace is always reporting a
 > state change for the entire group that contains the namespace where
 > the event occurred. That is the WHOLE POINT of ANA Groups. AND,
 > that is the whole point of TP4108 - to address that kind of situation
 > (where a change impacts only 1 namespace). Until TP4108 address this
 > situation, a single namespace changing the ANAGRPID is ugly. Maybe
 > we should get to work on that TP.

I ain't no member of a committee or something(unfortunately), so I have 
no idea what TP 4108 is about or where to find it.
But my main message on this passage was not in a sense how little data 
would be exchanged between target & hosts but rather for how many namespace
relation between them and associated with them ANA state would change, 
as to highlight the contrast between changing ANA state of a group and 
changing ANAGRPID of a namespace.
Again, I do not disagree that it's ugly but on the matter why I can't 
just go an assign each namespace(assuming NSID is global on my target 
system rather than one of the subsystems)
a separate ANA Group due to 8 times difference between allowed number of 
the first and the latter, I proposed to parametrize that in previous 
message but got no reply in that regard unfortunately.

Hope that more or less cleared things out.

Thanks for your time!

Best regards,
Alex


