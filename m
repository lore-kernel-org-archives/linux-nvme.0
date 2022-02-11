Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508C6C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Feb 2022 20:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mL8bRhkwqSBRRuxo/j3BaTxoye3B3YL/t/KtIP5l4Ug=; b=Ga3ZYgygH/ZIKC15xheVc/3G8H
	VwVe1UnpRtLqdXxQyRscyi3MgcY++m/7wG3RPaoHfT+G3GRBazq0PHoq/Tv0Vvu8o99AKhtQVRFEO
	vGRBgRn/PKX9x9OXPx7UY7kPGzMljsm/iT7Ow+5i5n1fiYl3sZEU34I4M0DBZ+dgS03yzekQwh1c2
	2n9uUcCm4mT2FUzSgmnk2iiqDKLPscJ/WZngUlL0DhM1JM6VgZT7dfjJjvOgs++6p0qJkTV7AvETw
	Z5heVez9M9ghfHn+A2WKMJCM+zxr8pIYVLVqGtjvUrfm4PJ/AOB56ScNsu05Gs4TaW1b97M2N41ud
	Oh8yhO+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIcvg-008k2X-2t; Fri, 11 Feb 2022 20:54:08 +0000
Received: from forward501o.mail.yandex.net ([37.140.190.203])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIcva-008jzm-LI
 for linux-nvme@lists.infradead.org; Fri, 11 Feb 2022 20:54:06 +0000
Received: from sas1-892da86383b1.qloud-c.yandex.net
 (sas1-892da86383b1.qloud-c.yandex.net
 [IPv6:2a02:6b8:c08:78a8:0:640:892d:a863])
 by forward501o.mail.yandex.net (Yandex) with ESMTP id 638A345C40AE;
 Fri, 11 Feb 2022 23:53:50 +0300 (MSK)
Received: from sas2-e7f6fb703652.qloud-c.yandex.net
 (sas2-e7f6fb703652.qloud-c.yandex.net [2a02:6b8:c14:4fa6:0:640:e7f6:fb70])
 by sas1-892da86383b1.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 xE9hpD4QM8-rneSvr1k; Fri, 11 Feb 2022 23:53:50 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1644612830; bh=mL8bRhkwqSBRRuxo/j3BaTxoye3B3YL/t/KtIP5l4Ug=;
 h=In-Reply-To:From:Subject:References:Date:Message-ID:To;
 b=lSBjPPWd+bFjrVXqoMTKC2CaxlrBwENL3pbMO3AbzfR7g4no+7J7NhJ/jL0sUutzx
 grR7SZEVlTPoL4l7ITNZiHq0uM0yRx83aDnfASbDsHfHaCCsZCXnIFAC4gs/7Immon
 VYh7VIUJ+L/0DhMxy/pPiDUjaxDlX0zazn4FgxQQ=
Authentication-Results: sas1-892da86383b1.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by sas2-e7f6fb703652.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id bU8TD6l1e7-rnHCdG2l; Fri, 11 Feb 2022 23:53:49 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Message-ID: <87d794b4-11d1-39a8-dba4-330b7c6e6f7b@yandex.ru>
Date: Fri, 11 Feb 2022 23:53:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: NVMe over Fabrics host: behavior on presence of ANA Group in
 "change" state
Content-Language: en-US
To: "Knight, Frederick" <Frederick.Knight@netapp.com>,
 linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>
References: <3fec0f6d-508c-c783-1779-a00e43fa2821@yandex.ru>
 <9a765265-0200-0eea-872f-780c4dbb69b8@grimberg.me>
 <02375891-2f92-c3d9-8a55-019b84c14c1c@yandex.ru>
 <205b91c3-4da1-744d-3d06-ccfdf2b93cff@grimberg.me>
 <5b5cfff7-6c07-0cb1-491a-0fa3d13c2cbd@yandex.ru>
 <fd8600bd-aa73-82f7-3ca7-ed7f766f1568@grimberg.me>
 <DM8PR06MB770480F38397C8FE8D4D0F22F1309@DM8PR06MB7704.namprd06.prod.outlook.com>
 <3de626e3-4d03-50a8-9bd2-c974227add02@yandex.ru>
 <DM8PR06MB77041FFF43B5E6C1CB9C2982F1309@DM8PR06MB7704.namprd06.prod.outlook.com>
From: Alex Talker <alextalker@yandex.ru>
In-Reply-To: <DM8PR06MB77041FFF43B5E6C1CB9C2982F1309@DM8PR06MB7704.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220211_125403_291614_5753126B 
X-CRM114-Status: GOOD (  55.45  )
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

Thanks for taking time to give the advance explanation! Now...

 > [FK> ] I'm not sure I understand that. Access state is always based
 > on the port, and ANA is totally about different access states on
 > different ports. If it was always the same on every port, then it
 > would be symmetric and there would be no need for ANA. The point of
 > the ANAGRPID is so the host can use a change of state reported for
 > one namespace to also recognize that an equivalent change has also
 > occurred for all other namespaces that have the same ANAGRPID.

I just meant that my setup is a little bit dumb.
In all previous messages I was talking in context of only one 
node("installation") but it's actually more cluster-like configuration 
on bigger picture.
Thus it is often (in my experience) when one namespace(i.e. underlying 
block device) needs separate attention at given while other aren't,
and ports rather disappear as a whole(for example due to broken cable) 
rather than part of the namespaces just unavailable on one of them.
Hence why I opted for such group configuration.
I do understand that the standard aims for more flexible path and it's 
okay, that's just too advanced for my application of this functionality.
One can also assume that namespace's NSID is global on such system for, 
again, pure simplicity.
And I do set NGUID to same value between nodes(when it's possible to 
have shared block device, present on all of them), so it's all fine and 
dandy in that part.

 > [FK> ] It would be fine for a host to track each NSID individually,
 > but they are unique only to a single NVM subsystem (if your host is
 > connected to an NVM subsystem from vendor 1, and also to an NVM
 > subsystem from vendor 2, then an NSID on the first subsystem is a
 > DIFFERENT namespace than the same NSID on the other NVM subsystem).
 > Dispersed namespaces are a different topic for a different thread.
 > And how a host does groupings of namespaces and how the ANAGRPID is
 > defined in the spec are independent.

The last statement precisely explains all the rest, since again, it's 
just my own setup and my own choice how to map things,
so as I highlighted above, in my case equal NGUID would likely yield 
equal NSID between different subsystems
(which might be setup in order to give different set of resources to 
different hosts, since list of allowed hosts is set in their plane in 
nvmet implementation).
I probably should had written a clearer explanation prior, sorry for the 
distraction.


 > Right now if a namespace changes its ANAGRPID, there is 1 AEN
 > required - for the ANA Log page contents changed (the NAMESPACE data
 > changed AEN is prohibited for this case). But, if the ANA changes in
 > the log page cause any groups to enter CHANGE state, then all
 > namespaces in that ANA Group are in the CHANGE state - not just the 1
 > namespace for which the ANAGRPID value changed. So storage that can
 > instantaneously change the ANAGRPID, the change is just about
 > inventory. But, for storage that takes time to move things around,
 > the whole "source" ANA group may enter CHANGE state (AEN), so the one
 > NSID can be removed (maybe another AEN), then the "destination" ANA
 > group enters CHANGE state (maybe another AEN), the "source" ANA group
 > can go out of CHANGE state (maybe another AEN), the "destination" ANA
 > group has the NSID added (maybe another AEN), and that "destination"
 > ANA group can go out of CHANGE state (maybe another AEN) - that means
 > stopping all commands to all the namespaces in both groups at some
 > point during that "move" process. How many changes happen (vs. how
 > many steps are combined), and how many AENs happen depends on how
 > long it takes, how many steps are merged vs. independent, and how the
 > host responds during that process. But no matter how it progresses,
 > that process is ugly, and something we wanted to optimize (via
 > TP4108). We hoped to create a way to optimize that transition.

So, did I got right, that it is advised to put ANA groups in "change" 
state when changing ANAGRPID(in sense of namespace attribute)?
Or did I completely lost the plot?
In any case, I sincerely hope that whatever is going on in this document 
I definitely have no access to reach, it's for the best!
I suppose I do get the basics of ANA groups tho(in regard that state 
changes for all group members at once) but thanks for the explanation 
anyway.

 > As for a group with zero attached namespaces - a host that uses RGO=0
 > will not get any state information about that group (it will simply
 > NOT be returned in the log page). If however, the host uses RGO=1,
 > then the host gets back a list of all groups and their states (and
 > there aren't ANY NSID values returned at all); meaning, there is no
 > way to determine from that data alone if there are any attached
 > namespaces or not. The point of RGO=1 is to be able to update the
 > state of the groups without having to parse all the NSID information
 > (just so it can be ignored).

Now I once again learned something new! So I get that RGO is an 
optimization, which is nice.
However, the piece of code I'm having problems with in this 
implementation(nvmet.ko) seems to opt for RGO=0
but I'm not completely sure. I did this conclusion based on the fact 
that nnsids is checked
withing a function I'm trying to patch (nvme_update_ana_state) and it 
clearly comes from the log.
Someone with more familiarity with the code base might give an idea 
whether RGO=1 is the case or it depends.

 > SO, what should happen for an ANA GROUP that has no namespaces when
 > that group enters CHANGE state. I don't see why it should be any
 > different than any other group. I'm not convinced a group with 0
 > namespaces is allowed to have any different behavior than a group
 > with 1 namespace attached. No group should remain in the CHANGE state
 > any longer than the ANATT timer value. However, when I read section
 > 8.10.4 Host ANA Change Notice operation (NVMe Base Spec 2.0), all the
 > recovery actions are described in the context of sending commands to
 > a namespace in the ANA Group, or the retries of commands being sent
 > to a namespace in the ANA Group. Obviously, that will never happen
 > for an ANA Group with no namespaces. EVEN the worst case scenario
 > says: "If the ANATT time interval expires, then the host should use a
 > different controller for sending commands to the namespaces in that
 > ANA Group." It's still about commands sent to namespaces. NOWHERE
 > does that text suggest a reset. If an ANATT timeout occurs - it says
 > pick a different path for sending commands to the namespaces in that
 > group (which is obviously a no-op when the group has no namespaces).

Why exactly the ANATT timer's function (nvme_anatt_timeout) opts for 
reset is unclear to me from the commit description to be honest.
The rest is my observation too.


> So if the timer is not started (because  there are 0 namespaces
 > attached) - and a namespace does come along (added to an ANA group
 > that is still in the CHANGE state), would the timer start when the
 > first command is sent to that namespace (and it fails with the
 > Asymmetric Access Transition)? That seems fine.

This is precisely what I'm aiming at with my patch in-progress, in this 
thread I just wanted to discuss its sanity prior to publishing,
the situation why I have the problem in the first place and to get other 
ideas on the way.
I'll double check but as far as I remember it worked fine with the patch.
So, just to be sure, you do agree then with my proposal that there's no 
point to start the timer prior to when at least one namespace becomes a 
member of such a group?

Much appreciated for your overall knowledge!


Best regards,
Alex


