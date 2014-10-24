From: asb@cin.ufpe.br (Angelo Brito)
Date: Fri, 24 Oct 2014 14:59:21 -0300
Subject: Questions on Interruption handling
In-Reply-To: <20141024174931.GT11522@wil.cx>
References: <CAMjVwgThWfs4M0pQy0QpfNONV_hv4rLQGXOPvh-OC9xkyvrHPA@mail.gmail.com>
 <20141023165339.GR11522@wil.cx>
 <CAMjVwgS5sv=rBS+FNSh7Np0Jn=uge9k00-3XLZ3M0=i0LEcjKw@mail.gmail.com>
 <20141024174931.GT11522@wil.cx>
Message-ID: <CAMjVwgQb9P7V6zv3YAFBBjW7wVOr2KO7obfdD3cYY3kZ3UqSzw@mail.gmail.com>

Thanks for looking into it.
Simply masking and unmasking the interruptions fixed our problems but
perhaps it creates other issues.
So please keep us posted. We will watch out ECN.

Regards,
Angelo Brito


On Fri, Oct 24, 2014@2:49 PM, Matthew Wilcox <willy@linux.intel.com> wrote:
> On Fri, Oct 24, 2014@01:51:59PM -0300, Angelo Brito wrote:
>> We can look more carefuly at those functions you stated, but perhaps
>> there is a small difference on how we are reading the spec. We do not
>> send a MSI for every single CQ because the spec states a different
>> functionality in section 7.5.1. It defines that the internal IS vector
>> should have a bit high when there are unanswered CQ entries and the
>> vector is not masked. The table then states that the MSI should be
>> sent only when a bit in the IS vector rises, meaning it either had
>> entries and was unmasked or it did not have entries and an entry came
>> in. I presume that was to reduce traffic in a very overloaded system.
>> This is for MSI and legacy only, of course, MSI-X uses a different
>> mechanism.
>>
>> Now, there is a window that we noticed. After the interrupt was
>> triggered it starts reading the CQs. It takes a few hundred
>> nanoseconds from the time the CQs have been read to the time the
>> doorbell arives at the controller, and the controller will take time
>> to process it as well, probably up to a few microsencods. If the
>> controller decides to write a new entry in a CQ in this time the
>> corresponding bit in the IS vector will already be high, therefore
>> there should be no new MSI. The host though already checked the CQs so
>> it will not see that new entries came in.
>>
>> We believe that is why section 7.5.1.1 states that the host should
>> mask interrupts and then release them. This way the host forces the
>> bits in the IS vector in the controller to go low and high again (see
>> section 7.5.1). If the host did not answer every single CQ entry, then
>> when the INTMC register is written a new MSI will be issued.
>
> Argh, the spec is buggy.  It should say that if the CQ doorbell write is
> less than the controller's notion of the CQ head, that the controller
> should send another interrupt.  I've sent in a request to the NVMe
> workgroup that we do an ECN to fix this.
>
