From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Jan 2017 16:40:00 +0200
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
In-Reply-To: <CANvN+emK-+HietjkUEuv9Ec=DYNN48jDQnpTiwm7UZMGz1hXig@mail.gmail.com>
References: <20170111134312.GH6286@linux-x5ow.site>
 <cc00cc1f-17d7-105e-ef2c-61791b7cc676@kernel.dk>
 <d60d4499-6ed8-0a69-edbf-db205a6dba6a@kernel.dk>
 <8b47ca34-d2ff-26dc-721e-2cb1e18f1efc@grimberg.me>
 <499af528-7810-f82d-1f11-cbf8f3a5b21c@grimberg.me>
 <53a3fb6c-c75a-519a-f669-2bcab404e01d@grimberg.me>
 <20170117162752.GE6067@linux-x5ow.site>
 <6df6bf6a-7cd3-1700-2b0a-e140325ebf47@grimberg.me>
 <20170118135156.GG3514@linux-x5ow.site>
 <e3438024-e0f2-db96-5122-4508863be603@grimberg.me>
 <CANvN+emK-+HietjkUEuv9Ec=DYNN48jDQnpTiwm7UZMGz1hXig@mail.gmail.com>
Message-ID: <a52f2192-81c8-24db-3657-98da3cc11ef7@grimberg.me>


> Your report provided this stats with one-completion dominance for the
> single-threaded case. Does it also hold if you run multiple fio
> threads per core?

It's useless to run more threads on that core, it's already fully
utilized. That single threads is already posting a fair amount of
submissions, so I don't see how adding more fio jobs can help in any
way.
