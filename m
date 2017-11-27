From: kevin@umd.edu (Kevin M. Hildebrand)
Date: Mon, 27 Nov 2017 08:44:58 -0500
Subject: NVMe array support
In-Reply-To: <20171123081048.GA15058@infradead.org>
References: <CAJmU7Q=P0cnSU1U0nVu3Tk8_kAajVEra1OWUPxCt8ZD3Qio9cA@mail.gmail.com>
 <20171123081048.GA15058@infradead.org>
Message-ID: <CAJmU7QnDd4Kzo62-smS+gqF9QBp4xvSCKHaA6_B+XCULbnf0SQ@mail.gmail.com>

Thanks for your comment.  I mentioned ZFS only as a possible test
case, to try to eliminate whether it was MD raid that was the
performance bottleneck, or something else.  I'm not planning on using
ZFS on these arrays otherwise.

Kevin

On Thu, Nov 23, 2017@3:10 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Nov 22, 2017@12:56:39PM -0500, Kevin M. Hildebrand wrote:
>> I've got eight Samsung PM1725a NVMe drives I'm trying to combine into
>> an array to be able to aggregate the performance of having multiple
>> drives.  My initial experiments have yielded abysmal performance in
>> most cases.  I've tried creating RAID 0 arrays with MD raid, ZFS, and
>
> If you want to use non-GPL licensed out of tree modules you are on your
> own, please don't waste our time.
