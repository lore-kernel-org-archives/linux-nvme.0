From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 6 Jul 2015 15:16:40 +0200
Subject: [PATCH v4 4/8] bio: Introduce LightNVM payload
In-Reply-To: <5571E79E.2050907@bjorling.me>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
 <1433508870-28251-5-git-send-email-m@bjorling.me>
 <5571E79E.2050907@bjorling.me>
Message-ID: <20150706131640.GF381@amd>

On Fri 2015-06-05 20:17:02, Matias Bjorling wrote:
> >-
> >+#if defined(CONFIG_NVM)
> >+	struct bio_nvm_payload *bi_nvm; /* open-channel ssd backend */
> >+#endif
> >  	unsigned short		bi_vcnt;	/* how many bio_vec's */
> >
> 
> Jens suggests this to implemented using a bio clone. Will do in the next
> refresh.

And I'd spell OpenChannel SSD the way you do in changelogs... for
consistency.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
