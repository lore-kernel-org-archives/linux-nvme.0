From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 4 Sep 2013 12:51:42 -0400
Subject: [PATCH] NVMe: Avoid caculate cq head doorbel in nvme_process_cq()
In-Reply-To: <5226FA47.10205@huawei.com>
References: <mailman.3257.1377730793.1059.linux-nvme@lists.infradead.org>
 <A103C806EC8D6E46A0D950DAA4D118D1400E0096@szxeml558-mbx.china.huawei.com>
 <20130903155316.GY4707@linux.intel.com> <5226FA47.10205@huawei.com>
Message-ID: <20130904165142.GA20931@linux.intel.com>

On Wed, Sep 04, 2013@05:15:51PM +0800, Haiyan Hu wrote:
> On 2013/9/3 23:53, Matthew Wilcox wrote:
> > Have you been able to measure a difference?  If so, can you share
> > relative numbers?
> 
> Sorry for my inaccurate description.
> Our test data shows that this patch does not change cmd process latency.
> But I think it can improve code efficiency, maybe a little.

Right, so it's a trade-off.  You want to add 8 bytes to the queue data
structure in order to save a few instructions from being executed at
queue processing time.  We need to quantify the savings (since we know
the costs).  I approximated the code by replacing:

-       writel(head, nvmeq->q_db + (1 << nvmeq->dev->db_stride));
+       writel(head, nvmeq->q_db);

Here's the code before:

     2ca:       48 8b 43 08             mov    0x8(%rbx),%rax
     2ce:       48 8b 93 88 00 00 00    mov    0x88(%rbx),%rdx
     2d5:       8b 48 40                mov    0x40(%rax),%ecx
     2d8:       b8 01 00 00 00          mov    $0x1,%eax
     2dd:       d3 e0                   shl    %cl,%eax
     2df:       48 98                   cltq   
     2e1:       48 8d 14 82             lea    (%rdx,%rax,4),%rdx
     2e5:       41 0f b7 c4             movzwl %r12w,%eax
     2e9:       89 02                   mov    %eax,(%rdx)

Here's the code after:

     2ca:       48 8b 93 88 00 00 00    mov    0x88(%rbx),%rdx
     2d1:       41 0f b7 c4             movzwl %r12w,%eax
     2d5:       89 02                   mov    %eax,(%rdx)

That's 6 instructions sved, and to be fair they have some pretty tight
dependencies.  Still, on a 3GHz processor, that's maybe 2 nanoseconds.
If we're doing a million IOPS, we could save 2ms/s, or 0.2%.  Pretty tough
to measure, let alone justify.

Here's an alternative that doesn't require adding 8 bytes to the
nvme_queue.  Instead of storing the shift in db_stride, we can store the
actual stride.  Then there is less calculation to be done at
completion time, and the code looks like this:

-       writel(head, nvmeq->q_db + (1 << nvmeq->dev->db_stride));
+       writel(head, nvmeq->q_db + nvmeq->dev->db_stride);

     2ca:       48 8b 43 08             mov    0x8(%rbx),%rax
     2ce:       48 63 50 40             movslq 0x40(%rax),%rdx
     2d2:       48 8b 83 88 00 00 00    mov    0x88(%rbx),%rax
     2d9:       48 8d 14 90             lea    (%rax,%rdx,4),%rdx
     2dd:       41 0f b7 c4             movzwl %r12w,%eax
     2e1:       89 02                   mov    %eax,(%rdx)

That saves half the instructions, for no increased data structure usage.

One other microoptimisation we can do is change the type of db_stride from
int to unsigned.  Then the compiler produces:

     2ca:       48 8b 43 08             mov    0x8(%rbx),%rax
     2ce:       8b 50 40                mov    0x40(%rax),%edx
     2d1:       48 8b 83 88 00 00 00    mov    0x88(%rbx),%rax
     2d8:       48 8d 14 90             lea    (%rax,%rdx,4),%rdx
     2dc:       41 0f b7 c4             movzwl %r12w,%eax
     2e0:       89 02                   mov    %eax,(%rdx)

which uses one fewer byte (at address 2ce, it uses mov instead of movslq).


Would you like to send a patch which changes the type of db_stride to
unsigned and changes the value stored there to be 1 << the current value?

Or you can try to persuade me again that the tradeoff is worth adding
the extra 8 bytes to the data structure :-)
