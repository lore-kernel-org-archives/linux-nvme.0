From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 19 Jun 2018 14:29:44 -0500
Subject: [PATCH v4 3/3] nvmet-rdma: support max(16KB, PAGE_SIZE) inline
 data
In-Reply-To: <75a24870-832c-1a4c-fe97-c1dfcf91c426@opengridcomputing.com>
References: <cover.1528219321.git.swise@opengridcomputing.com>
 <051c25edb1b0c0aa84b8195a95bdd3eb30d710f5.1528219321.git.swise@opengridcomputing.com>
 <98819370-459b-cad8-e89e-e2a128178dba@grimberg.me>
 <75a24870-832c-1a4c-fe97-c1dfcf91c426@opengridcomputing.com>
Message-ID: <be676b5f-4de2-ef66-82c0-bd7263c1892e@opengridcomputing.com>



On 6/19/2018 9:35 AM, Steve Wise wrote:
>
> On 6/19/2018 6:59 AM, Sagi Grimberg wrote:
>>
>> On 06/05/2018 08:16 PM, Steve Wise wrote:
>>> The patch enables inline data sizes using up to 4 recv sges, and capping
>>> the size at 16KB or at least 1 page size.
>> Question: any reason for that cap? Just seems like an arbitrary limit...
>>
> It was there in the original patch series, and I continued it.? I guess
> the idea is we don't want to be a memory hog.
>
>> ? So on a 4K page system, up to
>>> 16KB is supported, and for a 64K page system 1 page of 64KB is
>>> supported.
>> Well if someone asked for 16K and got 64K its a bit of a surprise
>> isn't it? without exposing knob for this, using 64K OK I guess, but when
>> we expose controls for this its a bit surprising.
>>
> I'm open to proposals for a better way to do all this.? Like perhaps
> just a knob for how many pages to allow?
>
>> Would page_frags work better here? (page_frag_alloc/page_frag_free)
>> Given that most likely the backend device will work with 4K pages, the
>> fragments won't cause gaps...
>>
> There's no comments on this API.? How does it work?? It allocates some
> number of contiguous fragments < a page?
>
>> Thoughts?
>>
>> ...
>>
>>
>>> +static int num_pages(int len)
>>> +{
>>> +??? return 1 + (((len - 1) & PAGE_MASK) >> PAGE_SHIFT);
>>> +}
>> Steve, can you explain why is this needed? why isn't get_order()
>> sufficient?
>>
> I thought get_order() gives you a power of two >= the length. ie 1, 2,
> 4, 8, 16.? For inline_data length of 12KB, for example, we want 3 pages,
> not 4.? Or am I mistaken?
>
>

Just to clarify here:? The target never allocates more that a single
page per recv SGE for inline data.? That was a change from v3-v4 of this
series.? I eliminated any page allocations of order > 0.? So num_pages()
is there to compute the number of pages used to represent len bytes of
inline data.? IE <= 4KB, 1 page. ? > 4KB and <= 8KB, 2 pages, etc...

Steve
