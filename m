From: axboe@fb.com (Jens Axboe)
Date: Tue, 22 Nov 2016 08:53:00 -0700
Subject: [PATCH 00/12] block: cleanup direct access to bvec table
In-Reply-To: <1478865957-25252-1-git-send-email-tom.leiming@gmail.com>
References: <1478865957-25252-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <167c2511-349f-a8e6-17d1-f7ce438b2f14@fb.com>

On 11/11/2016 05:05 AM, Ming Lei wrote:
> Hi,
>
> This patchset cleans up direct access to bvec table.
>
> The 1st patch passes bvec table to bio_init(), so that
> direct access to bvec table in bio initialization is avoided.
>
> For other patches, most of them uses bio_add_page()
> to replace hardcode style of adding page to bvec,
> and others avoids to access bio->bi_vcnt.
>
> The most special one is to use bvec iterator helpers
> to implement .get_page/.next_page for dm-io.c
>
> One big motivation is to prepare for supporting multipage
> bvec, but this patchset is one good cleanup too even not
> for that purpose.

I've added the series, except 6-8, the dm parts. I updated some of the
descriptions/subjects to read a little better.

-- 
Jens Axboe
