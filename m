From: luto@amacapital.net (Andy Lutomirski)
Date: Wed, 21 Sep 2016 17:11:03 -0700
Subject: [PATCH v4 0/3] nvme power saving
In-Reply-To: <cover.1474049701.git.luto@kernel.org>
References: <cover.1474049701.git.luto@kernel.org>
Message-ID: <CALCETrVeJPzxhue5=Jj1uhF3=skVwkbVOQvjEPMYH=DvJBfNjw@mail.gmail.com>

On Fri, Sep 16, 2016@11:16 AM, Andy Lutomirski <luto@kernel.org> wrote:
> Hi all-
>
> Here's v4 of the APST patch set.  The biggest bikesheddable thing (I
> think) is the scaling factor.  I currently have it hardcoded so that
> we wait 50x the total latency before entering a power saving state.
> On my Samsung 950, this means we enter state 3 (70mW, 0.5ms entry
> latency, 5ms exit latency) after 275ms and state 4 (5mW, 2ms entry
> latency, 22ms exit latency) after 1200ms.  I have the default max
> latency set to 25ms.

Anything I can/should do to help this make it for 4.9? :)

--Andy
