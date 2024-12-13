Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2620BE77180
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2024 19:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q2Hh7i1IvMPkDPyJ+H+GPqol4Inldj3eRd/RH+IyPWA=; b=1yyZvuz7xrqn5vNE6+r4dGuyKB
	GM8JTEvVdgRKu9unELOsvymbg+6PvZ54byHUcQXEJvHikxTPyemaTASStajXizhA+8qUuYed+oxbV
	lwIDatb98li5v1LL7gyYCOpI5ElwmsL3P0fs+gYMPT2V9n4xaaUU9BThxByh7UrKZp/qDU4GYpSMW
	DB7poUvezGieF+UnGu7B4f3bkFfdxse8lbSmVR/SR6tMxig7PRelskXp3fjwH0c32NufW+0DfUalV
	JObcgqaurueFKM1rD3i6iZubYOhKr/pS/3slPJ4zaa225OHf244NCElD277DtQijQXZhDhAbHMFXc
	8mBZYUsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMAu1-00000004jjA-0tmT;
	Fri, 13 Dec 2024 19:00:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tMAtj-00000004jgB-2nKi
	for linux-nvme@bombadil.infradead.org;
	Fri, 13 Dec 2024 19:00:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Q2Hh7i1IvMPkDPyJ+H+GPqol4Inldj3eRd/RH+IyPWA=; b=aTdyCVo0A04ii9Be59koxPyCGw
	E2Tc3gu9An0oYSw9mHUF4BGt68XuQnuY7+qEv5mkl8S/1Mb8OjHTdPRLU0Y8nSm9EmCuNg7Z3wqqy
	Gg5gNAXSG5wpcILgrKOSICOswOFwoAOw2xu5W3peK6/AB0NW9WDuFXCZ7pkBtkOFbvrxQ/H/Wso/7
	vup/1RzSjj5IdPAXwNmGeAuD9eAGVay0ADicmlvi1bgfEe78EBpB3K0vpdptd3ZJgBtpkK/k30Da6
	mWavV6+5CbolAjztRsfwtkpu703L7ZYCER9Q3dAaS2BVWWPNc2kEPctCfSAxVGrJ7DNTtle0nUDG7
	bbwW1yNA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMAtg-0000000F6TE-2gCj;
	Fri, 13 Dec 2024 19:00:20 +0000
Date: Fri, 13 Dec 2024 19:00:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Michal Hocko <mhocko@suse.com>
Cc: lsf-pc@lists.linuxfoundation.org, linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: LSF/MM/BPF: 2025: Call for Proposals
Message-ID: <Z1yERChJxMKlZ5nZ@casper.infradead.org>
References: <Z1wQcKKw14iei0Va@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1wQcKKw14iei0Va@tiehlicka>
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

On Fri, Dec 13, 2024 at 11:46:08AM +0100, Michal Hocko wrote:
> The annual Linux Storage, Filesystem, Memory Management, and BPF
> (LSF/MM/BPF) Summit for 2025 will be held March 24–26, 2025
> at the Delta hotel Montreal

I've written an opinionated guide to Montreal.
Patches accepted, latest version can be found at
https://www.infradead.org/~willy/linux/lsfmm2025.txt


Montreal
========

Montreal is the second-largest French-speaking city in the world.
Despite that, you can generally manage without speaking any French;
they are accustomed to tourists.

Transport
=========

Montreal primarily uses the metro; it is an entirely underground system.
Entrances are indicated with a blue downward pointing arrow.  The Delta
hotel is between McGill and Place-des-Arts metro stops on the green line.
Train announcements are only in French but signage is bilingual.

Tickets for the STM (https://www.stm.info/en) are valid on both busses
& metro (but not local rail which is a different system that you won't
need to care about anyway).  Travel to and from the airport is a special
$11 fare which includes 24 hours of travel.  You can use a credit card
to buy fares from a big orange machine; while you can pay on the bus,
everybody will look askance at you for slowing them down.  You'll get
a credit-card sized piece of card with an embedded antenna; you can
break it by folding it, and it is not recyclable.  While you could buy
a plastic OPUS card, this will not be a wise investment decision.

From the airport, you'll want to take the 747 bus to Lionel-Groulx, go
down into the Metro and catch a green line train towards Honore-Beaugrand,
getting off at McGill.  For getting back to the airport, you will again
need to buy an $11 ticket for the 747 bus.  If you're travelling, say,
Thursday evening, you might want to buy your special $11 ticket on
Thursday morning, use it to travel around the city and eventually catch
the 747 in time to catch your plane.

I would not recommend driving in Montreal.  It is confusing and expensive.
I'm going to take the train from Ottawa, but taking the train from New
York is a 11+ hour ride.  I'm told it's very pretty!  There are also
coaches (Flixbus / Greyhound / etc) but I have no experience with those.

You can rent a bicycle by the minute: https://bixi.com/en/
Scooters are probably not available to rent during winter.

Beer
====

The closest brewer to the conference is Benelux.  They don't open until
mid-afternoon, but the Provigo grocery store across the street sells
their beer if they're not open.  It's not generally legal to drink on
the street; take the beer back to the hotel before opening it.

Other worthwhile breweries include Dieu de Ciel, 4 Origines, Saint Bock,
Brewsky and McAuslan (aka St Ambroise).  Don't be afraid to use the
metro to visit them.  There are many pubs on Crescent and de la Montagne
streets; most will serve local beer.  Cans of beer are readily available
at corner shops (referred to as "dep", short for Depanneur).

Molson is headquartered in Montreal.  It is not usually considered
local beer.

Food
====

Montreal prides itself on food.  Classic dishes include poutine, smoked
meat and tourtiere.  As a major city, there is plenty of international
food.  Montreal and New York have different styles of bagels from each
other and much ink has been spilled on the subject of which is superior;
try St Viateur or Fairmont for a fair example of Montreal bagels.

There is also fierce competition as to whether Quebec, Ontario or
Vermont produces the best maple syrup.  You should probably find a
Cabane a Sucre / Sugar Shack to form an opinion of your own, eg
https://www.parcjeandrapeau.com/en/urban-sugar-shack-spring-restaurant-sainte-helene-bistro-terrace-montreal/

Outside
=======

We're going to be there in March.  It could be -30C or +20C.  Montreal
has an underground city (RESO) which has shops and restaurants, as
well as being a sheltered route between office towers and the metro.
There's an entrance at Union street, just two blocks from the hotel.
https://www.mtl.org/en/experience/guide-underground-city-shopping
(yes, that is a chunk of the Berlin wall in the picture)

If the weather is clement, Mont Royal is a popular destination, but it
can be icy and not much fun at this time of year.  The Lachine canal may
be a better bet, or you can walk or cycle on the Formula 1 circuit on
Ile Notre Dame.  It's not the Nurburgring; while you can drive on it,
the speed limit is 30kph.  A more unusual route would be the Samuel
De Champlain bridge Multiuse Path which is some of the best tarmac in
the city (but ends on an unsurfaced path that connects to the Formula
1 circuit).

The local sport is hockey.  The Habs are not having a good year, so you
may be able to buy tickets to a game.  The Colorado Avalanche are in town
on Saturday 22nd; otherwise you should be able to watch a game in a pub.
Women's hockey is gaining in popularity, and the Montreal Victoire are
playing Toronto at Place Bell at noon on Sunday 23rd.

St Catherine, St Laurent & St Denis are the major shopping streets.
There are markets at Atwater and Jean Talon.  The Vieux Port area
is full of tourist tat (but maybe you want a sweatshirt with Montreal
written on it).

The Biodome and Biosphere are both worth a visit.  There's also a
planetarium, the Musee des Beaux Arts and the botanic gardens.  I like
the Archaeology museum.

