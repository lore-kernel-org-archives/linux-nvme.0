Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A258C79F99
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2026 10:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ty41fI7W/6326KYJPKqFqKfzEM+SUiXu9+OGriuwfc0=; b=y+j1luaJHUx0Cz7XSAs2U0242T
	cATW58Ps48rYpRqy8jCY3pdLEPJtTPOrse/o04PA/7lIT47oNaURlYhyMixIXQJ0zrdEvZwn0oEr+
	WBJLJJT4rZRZvkSz7nMykwtG5uClMi43x2yGvFjkfYp505FdXsEON6v0bON9DB3UBq6Q5siIcu4Vr
	lC4UaVMM/kKSi3QPZ8G3Ct3c9BeJs/uJko9xL5S1BMZD0tR1hknTsgDfH5ixfWGPoAjv7tmwJUDqr
	AhXQKDkMFuOcCaKxbAeQhK2acFbkr4V0LZ19k6sbicHjbbzb4mDaUXTYyT1lygp6ljd7ZEWH1+U71
	XCrlW5qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3WHm-00000006S5U-0lNc;
	Mon, 07 Sep 2026 10:09:10 +0000
Received: from mail.nearlyone.de ([49.12.199.46])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3WHj-00000006S4j-2DfO
	for linux-nvme@lists.infradead.org;
	Mon, 07 Sep 2026 10:09:09 +0000
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Subject:From:To:Date:Message-ID; t=1788775739; bh=Ty41fI7W/6326KYJPKqFqKf
	zEM+SUiXu9+OGriuwfc0=; b=PsqTttEh4zxBMHJ1SNEERkRY3/L8ZMNVZlo83xRHMFlNNDlihG
	KQptl4BM7ic6wuyfHEVUmFWDHt7NhkGe+jBQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Subject:From:To:Date:Message-ID; t=1788775739; bh=Ty41fI7W/6326KYJPKqFqKf
	zEM+SUiXu9+OGriuwfc0=; b=2IMYoJ+iyMinWWGIDFPVQjUCpMgli7f7BgY1NXI4dI+iLCSZgM
	99WWe+dpuBH7G1CIA8Dl6TtMNeGbp8X5Fa6Yzoq6SBaTvowy06pIRYshUYZZMBkzBS+VYetZELZ
	UhS2zil3RUaAAtM8vnFyRmmxpqTpBGCFoe/XP+ELs9PCeJLOr0ATMjrdVO6GU5v2tdakDcUIKKE
	biUC/onxipk4rXivL48K7Pu21J+w/27gPHEFJJwjaqLuhMMky80lL8POSqplNCuwzKMtRJ18nrK
	Hf08+2XY5nf1WcamebF8TV32gEsFx2ZTs8LKzMoZs797ChoX1Py421OVQiUrYE+KYOA==;
Message-ID: <28526c72-3bf7-48b5-b433-009c9289d1bb@monom.org>
Date: Mon, 7 Sep 2026 12:08:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-nvme@lists.infradead.org
From: Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] nvme-cli 3.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_030907_830819_1765D5B3 
X-CRM114-Status: GOOD (  21.76  )
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

nvme-cli 3.0 is finally out. Here is the story how we got here, plus
some stats, because I think that's more interesting than a plain
changelog.

nvme-cli 2.x life started back in 2020, right after the 1.10
release, when Keith Busch started with libnvme. Splitting the
nvme-cli 1.x code base into a CLI part and a library. Hannes Reinecke
saw the opportunity to provide a Python binding via libnvme which
was the base for the nvme-stas project.

The split was not easy and took quite a while, which meant we had
nvme-cli 1.x still shipping and an unreleased 2.x branch sitting on
top of it at the same time. Around that time, at an ALPSS conference,
I asked Keith Busch if he needed help getting nvme-cli 2.0 out the
door, and suddenly I was a maintainer.

As one can imagine, if a library is cut out of an existing project it
usually ends up with some rather unusual APIs. Fine for an internal
API, not so great for a library interface. I tried for the initial 2.0
release to get this sorted out, but it was clear that would take too
long. So the decision was made to release it anyway and do another
major version a couple of years later, once we'd figured out how to do
it better. nvme-cli 2.0 shipped on 2022-04-08.

It took a bit longer than that until the 3.x project actually started.
The wish list grew over the years, but I thought it would be good to
just do a refactoring/cleanup release. No new features, just get the
existing API sorted out, and do it quickly, a few months at max.
Dennis Maisenbacher and Tokunori Ikegami helped a lot in that early
3.x phase, where we manually went through the existing API and
refactored it. Very tedious work.

When presenting these plans and status at ALPSS 2025, Christoph Hellwig
suggested we take the time and do it properly. So we did. Around May
2026 the code base was in good shape and I considered it 3.0-ready.

At LSF/MM 2026 I presented the status, plus some future plans,
accompanied by prototypes of how to move forward with connection
management for NVMe over Fabrics. Bring these things into the
current millennium. Again, Christoph suggested to get this done
properly, so the 3.0 release got postponed again, to look into the
future plans and the new features that were originally not planned
for 3.0 at all.

And this is when we started using AI in earnest. The impact was huge.
All the "this would be really cool to have, but too much work right
now" features suddenly became doable. Martin Belanger started
bringing major features from the nvme-stas project into libnvme,
while I was busy splitting up the code base further to make it more
portable.

We moved a lot of code from left to right (some would call it code
churn), but my mindset for this phase was progress over perfection.
The result is that we haven't just cleaned up the public libnvme API.
We have a much cleaner code base overall, and a few major new
features on top.

This cleanup, and the abstraction of some base types out of the
library, enabled another interesting side project. Brandon Busacker
asked me early this year if I was open to porting the project to
Windows, and a few months later, after getting libnvme into shape, it
was actually reasonably doable. Broc Going and Jim Munn provided the
platform-specific parts, and voila, it runs on Windows now.

I thought I needed to counterbalance this, so I asked Claude if it
could do a port to FreeBSD, and a few minutes later nvme-cli was also
running on FreeBSD (not merged yet, because first I want CI working
so any bit-rot gets noticed in time).

Another effort worth mentioning: Sarah Ahmed, Brooke Ellis, Fahim
Hassan and Laraib Javed, all from IBM, started bug-squashing the
reports from clang-analyzer and Coverity, with guidance from Nilay
Shroff. Nilay also contributed the new 'nvme top' feature, after I
convinced him at LSF/MM 2025 it would be a great thing to have. These
bug-hunting efforts got extra support from Prabhakar Pujeri in the
final weeks before release.

The whole effort shows up in the numbers, too: nvme-cli 2.x/libnvme
1.x had roughly 47 test cases total, with code coverage around 2%.
nvme-cli 3.x/libnvme 3.x has over 140 tests now, and coverage around
24%. Still not great, but clearly progress.

git log naively reports 3,681 commits since v2.16, but that walks
into libnvme's own pre-2.16 history too, since the "lib: import
libnvme sources" merge preserved it instead of squashing it. Follow
the real mainline only and it's 1,711 commits from 58 people.
The incremental work since v2.16 comes out to roughly
+113,600 / -38,686 lines.

I also went looking for how much of that came from AI. Counting
commits with an "Assisted-by"/"Co-authored-by" trailer, an explicit
mention in the message body, the em-dash-heavy prose style that
basically no human here actually writes in, or my spec-update commits
pulling into libnvme, that's at least 168 commits, 98 of them Martin
Belanger's and 59 mine, adding up to roughly +32,500 / -14,000 of
the real lines above.

58 people committed code between v2.16 and v3.0. In alphabetical
order:

Alexandr Goncharov, Ben Reese, Brandon Busacker, Brandon Capener,
Brandon Paupore, Brenden Bain, Broc Going, Brooke Ellis, Carl Moran,
Daniel Wagner, David Santamaría Rogado, Dennis Maisenbacher, Fahim
Hassan, Federico Iezzi, Flavien Solt, fyodor-soiguine-sndk, g0l4,
Gopinath P, Guangzong Chen, Guzebing, Hannes Reinecke, Haro Panosyan,
hsdhillo, jeff-lien-sndk, Jesse Taube, Jian Zhang, Jim Munn,
jinhua.huang, Kou Wenqi, Laraib Javed, Leonardo da Cunha, Markus Kurz,
Martin Belanger, Martin George, Martin Wilck, Maurizio Lombardi,
Michal Rábek, Mitsuru Kariya, Nate Thornton, Nick darkfiberiru Wolff,
Nilay Shroff, orbisai0security, Prabhakar Pujeri, Praveen Kumar B,
Robin-YMTC, Sarah Ahmed, Sebastian Chlad, sfindley102892, Stephen
Cheng, Steve Chang, Steven Seungcheol Lee, Stuart Hayes, Swapna
Samoju, Tokunori Ikegami, Tomas Bzatek, Utkarsh Singh, Zhen Wang,
胡玮文.

Plus everyone who filed a bug, tested an rc, or reviewed a patch
without their name ending up in git log.

So, many thanks to anyone who contributed to the 3.0 release. If I
forgot to mention you it's not on purpose, just lossy brain function
on my side.

This release is certainly not perfect, e.g. the libnvme API is way
better than in the previous major version, but still not where it
should be. So let's find out what's broken in the 3.x API next, and
fix that in the following major version.

See https://github.com/linux-nvme/nvme-cli/blob/master/NEWS.md
for more details.

--
Daniel

