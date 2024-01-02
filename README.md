### Université Bordeaux Montaigne - Master Études Anglophones - Variation and Change in Language (3MIAM44)

### END-OF-TERM RESEARCH PROJECT

# Tweeting Transformation: Analyzing the Evolution of Sentiment in Elon Musk's Twitter Activity

Stephane Popov

Abstract

> This research delves into the evolution of sentiment within Elon Musk's tweets over the past decade. Using sentiment analysis through a lexicon-based algorithm, we investigate the dynamics of his online discourse and explore whether a discernible and statistically significant trend in sentiment exists over time. The data reveals a notable decline in sentiment, particularly in Musk's replies to others, potentially indicating a shift towards more contentious and controversial interactions. Additionally, the study raises questions about Musk's motivations behind acquiring Twitter, suggesting a desire for greater influence over content and platform policies. While his recent actions have shaped Twitter to align more closely with his principles of free expression, this shift has come at the cost of revenue and raised concerns about content moderation. The research discusses the implications of these findings and acknowledges the study's important limitations, highlighting the need for further exploration into potential external factors influencing Musk’s sentiment.

Keywords: sentiment analysis, social media

0. **Introduction**

The advent and subsequent widespread adoption of the Internet have significantly transformed the way individuals express their opinions, viewpoints and feelings on various topics and matters. Instant online communication and information dissemination have been further accelerated by a variety of social media platforms such as X (formerly Twitter), where individuals often share their perspectives through brief messages, commonly referred to as tweets.

Sentiment analysis attempts to gauge how people feel towards a particular subject or product using either tools such as machine learning and natural language processing, or a lexicon-based approach. Beyond its obvious business application in terms of analyzing customer psychology and behaviors in order to gain an edge in marketing and product development, sentiment analysis also has utility in more diverse and less commercial domains such as linguistics, sociology and politics by analyzing public opinions.

In the pursuit of a deeper understanding of how public figures use language to engage with the world through social media and how this engagement evolves over time, I decided to focus on analyzing the sentiment within all of Elon Musk's tweets over the years. This investigation is driven by nothing more than a genuine curiosity regarding the shifts in sentiment that may have occurred in his Twitter activity over time. My working hypothesis was that the sentiment expressed in Elon Musk's tweets has probably exhibited a discernible downward trend in recent years, manifesting in a more negative tone. This hypothesis is rooted in the observation that Mr. Musk was so unhappy with the platform that he ultimately opted to purchase it at no small cost, take it private and re-brand it, a significant decision that I believed could potentially be correlated to changes in the sentiment of his tweets.

Through this research, I aim to shed light on the dynamic relationship between language, prominent individuals, social media platforms, and the evolving sentiment within their online discourse. This investigation holds the potential to uncover valuable insights into the interplay of sentiment and high-profile Twitter engagement, offering food for thought on the broader implications of these interactions.

1. **Literature Review**

There has been a notable surge in sentiment analysis research recently. Mäntylä et al. (2017) presented an incredibly in-depth computer-assisted literature review, analyzing 6,996 papers relating to sentiment analysis, finding that “99% of the papers have been published after 2004”. They note that while early usage of the practice started with online product reviews, social media text analysis has become one of the main usage of sentiment analysis, with applications and use cases including stock markets, elections and cyberbullying among many others.

Two primary methods for conducting sentiment analysis are the machine learning approach and the lexicon-based approach. The machine learning approach involves the use of algorithms to discern and extract sentiment from data, whereas the lexicon-based takes a quantification approach, looking at the amount of positive and negative words in the given data (Drus et al., 2019).

Sahu & Ahuja (2016) adopted a methodology grounded in lexical analysis to look at sentiment polarity in a movie review database. Their approach entailed a comprehensive examination of the words in their dataset and deriving an aggregate polarity score. Their research is particularly interesting, due to a “lack of strong grammatical structures in movie reviews which follow the informal jargon”, which is definitely something to be held into consideration when it comes to tweets as well.

2. **Methods**

In my analysis of Elon Musk's tweets, which I sourced from a dataset on Kaggle, I've chosen to leverage the sentimentr R package. R is a powerful programming language and software environment primarily designed for statistical computing. Its robust ecosystem of packages offers various tools for data analysis and visualization, making it an ideal choice for this venture.

The reason for choosing the sentimentr package lies in its unique capacity to account for valence shifters, such as negators, amplifiers, de-amplifiers, and adversative conjunctions within the context of English text. These linguistic nuances can substantially impact sentiment. Tyler Rinker, the package’s main developer, says that “In the case of negators and adversative conjunctions the entire sentiment of the clause may be reversed or overruled”. This package strikes a balance between computational efficiency (speed), and accuracy by taking these valence shifters into account. This way, the subtleties and informal language in Elon Musk's tweets are properly captured and evaluated. This nuanced sentiment assessment is pivotal in understanding the sentiment trends and variations in Musk's communication, and it plays a crucial role in the quality of my research conducted on his Twitter activity.

I started by taking the dataset and extracting the text, or body of the tweets. Then I removed the number of comments, likes and re-tweets using regular expressions and the gsub method. Regular expressions are a pattern matching tool widely used to find, extract, or remove text data depending on specific patterns or rules, based on a sequence of characters. Using regular expressions as arguments in the “gsub” function (Global Substitution) helped me match the pattern I was looking for to remove the tweet likes, re- tweets and comments so as to make sure the sentiment analysis doesn’t misbehave, since I am using a lexicon-based package and these trailing numbers would not be needed.

To discern Musk’s own tweets from his mere replying to other tweets, I used the “grepl” function (Global Regular Expression Pattern Matching and Selection) to select which tweets started with the character vector “Replying to”, summed them and saved both outputs into separate variables for further analysis and comparison.

I made sure to normalize all timestamps to a specific format ("%Y-%m-%dT%H:%M: %S"), or the ISO 8601 standard, which is widely recognized and preferred in many data analysis and visualization tasks because it's easily interpretable and can be directly converted to POSIX objects, making it the gold standard for easy and efficient handling of date and time operations in R.

After running the cleaned and processed tweet data through functions of the sentimentr package, and saving them to different data frames where I combined them to the matching timestamps, it was time for some plotting. I quickly realized that graphs such as scatterplots would be the wrong types of graphs, not only due to the sheer volume of tweets (over 12,000 of them), but also because I noticed that although there were some outliers, the fairly even distribution of sentiment scores made it seem as if there was no trend. I could have went for a simple averaging of the data based on an arbitrary interval, be it a day, a week or a month. However, I decided against this method as I figured it would not accurately describe sentiment change, especially since there were periods of time with more tweets than others. A given week with ten times more data or tweets than usual would be given the same weight, and this would not paint the whole picture. Therefore, in order to find more accurate and discernible trends, I had to run a method to specifically smooth out my data, not simply average it. I decided to apply the "loess" method (Locally Weighted Scatterplot Smoothing). This method fits a non-parametric regression model to the data, allowing for non-linear trends. It's a good choice when the data has complex patterns, which is exactly what was needed here.

3. **Results**

As mentioned previously, the dataset is very complex and varied, as can be seen using a simple scatterplot. A large number of both positive and negative outliers make the y axis very broad, which explains why I decided to smooth out the data.

![Tweet Sentiment Over Time Scatterplot](https://i.imgur.com/gV9jKtI.jpg)

After applying the Locally Weighted Scatterplot Smoothing method, a trendline became much more discernible. Firstly, it is important to point out that the smoothed out trendline is always positive, starting around a value of 0.12 and dropping below 0.08 at the time of his last available tweet. One can however discern a notable downtrend over the years, with the trendline slowly but clearly dropping by more than 30% by the end of the available data compared to the highs of the early 2010s.

![Sentiment Over Time - LOESS](https://i.imgur.com/qHD5qBm.jpg)

In order to understand and try to explain these results, I decided to look at the proportion of tweets which were Elon Musk’s own tweets (a sort of status update) compared to the amount of reply tweets he has made, meaning whenever he responded to someone, engaged in a conversation or argument. As you can see in the console output generated below, almost three quarters of all of Elon Musk’s tweets were actually replies, meaning less than 28% of all tweets in the data set and Musk’s tweeting history are actual status updates.

![Console Output](https://i.imgur.com/F6M0mbE.jpg)

Digging deeper, since I had duplicated and separated his own tweets and replies into different separate data frames, I decided to run sentiment analysis functions on those separately and plot the data, using the same methods and functions at every single step to ensure the results can be accurately compared. As can be seen in the graph below, one can not point to a significant increase or decrease in terms of sentiment in Elon Musk’s own tweets over his decade of tweeting. There is no clearly discernible trend.

![Sentiment Over Time for Own Tweets](https://i.imgur.com/hNaAIHn.jpg)

His replies paint a different picture though. Firstly, the range itself is lower than for his own status updates. The trendline in Musk’s own tweets moves from around 0.85 all the way up to 0.13, before stabilizing around 0.11. The trendline for his replies on the other hand, starts no higher than 0.12, and steadily drops all the way down to 0.06, a singificant decline of 50%. The range difference means that in general, his replies have a worse sentiment to them than his status updates. On top of that, the trend itself shows an undeniable decline in sentiment over the 10+ years of Elon Musk’s tweeting history.

![Tweet Sentiment Over Time for Replies](https://i.imgur.com/MBzuFAK.jpg)

The difference in trend between the two is even more apparent when overlapping them.

![Tweet Sentiment Overlapped](https://i.imgur.com/HmqjU6P.jpg)

4. **Discussion**

Firstly, there is a discernible downward trend which points to a negative shift in the sentiment of Elon Musk's tweets over the years. However, the fact that a substantial proportion of his tweets are replies (over 70%) is noteworthy, as it suggests that a significant part of his activity is engaging with others in the form of responses and conversations, reflecting his willingness to address criticism, respond to followers and engage in debates. Furthermore, there is no clearly discernible trend in Musk’s own tweets, so the fact that almost three quarters of his tweets are replies and the fact they have a significant downward trend explains why the overall trend is negative. On top of that, it is important to note that his replies have a lower sentiment range as well.

While his own tweets exhibit relatively consistent sentiment over the years, the fact that his replies show a significant decline in sentiment suggests that his interactions and conversations may have become more contentious and less positive over time, indicating a potential shift towards more confrontational and controversial interactions.

Furthermore, with X being a platform on which it is very easy to get into heated arguments, it is not surprising at all to see Mr Musk’s actual tweets having a better sentiment score than his replies. One can say his interactions with the wider world has slowly but surely deteriorated in terms of sentiment. The sheer size difference in replies compared to the number of his own tweets also shows that Musk is more likely to respond to someone than to tweet a status update. The fact that sentiment in his replies has steadily fallen over the years could definitely be a symptom of Mr. Musk’s dissatisfaction with the Twitter platform, ultimately opting to purchase it at no small cost as mentioned earlier, taking it private and rebranding it to X.

It's unclear as to what his motivations were for this bold move. I theorize that Musk's decision to purchase the platform may be rooted in a growing dissatisfaction with certain aspects of it, as can be seen in the decline of sentiment in his tweets. Over the years, he's been engaging in public debates and discussions on the platform, often attracting significant attention and controversy. Could Musk's desire for greater control and influence over Twitter's policies and content have been a driving force behind the acquisition? Ever since taking over, he's shaped the platform to align more closely with his own ideas and objectives, such as more freedom of speech, leading to concerns regarding content moderation and the influence of various voices on the platform.

This is why I raise the question of his motivations, particularly when it appears that profit-making might not be the primary goal. Musk's recent relaxation of content guidelines has had significant consequences, including the departure of a non negligible amount of advertisers. As a result, X's ad revenue has experienced a notable decline, with Musk himself acknowledging a 50% drop. Bloomberg journalists Aisha Counts and Tom Maloney have noted that Twitter, or X, is now "worth just one third of what Elon Musk paid for it".

I suggest therefore that Musk's interest in Twitter may have extended beyond financial gain. It seems he is willing to prioritize a more open platform over immediate profitability, reflecting a commitment to the principles of free expression, freedom of speech and open dialogue. This stance aligns with Musk's history of advocating for a more unrestricted exchange of ideas on social media platforms. However, this is a double-edged sword because by allowing for a more unrestricted platform, both through relaxed content moderation and reinstatement of formerly banned accounts, Musk's new Twitter has seen a surge in problematic and extreme content, with racial slurs soaring and hate speech rising to unprecedented levels.

Nonetheless, it is important to note a few things. This research is based on a dataset of tweets, which does not represent Musk's entire social media activity and may not represent his thoughts accurately. Furthermore, it's essential to acknowledge that Twitter engagement can vary, and this dataset may not capture all interactions. On top of that, different sentiment analysis tools may yield different results. The sentimentr package I used is designed with a healthy balance of speed, computing efficiency and accuracy in mind, but it is not the most accurate algorithm out there. Stanford's coreNLP algorithm seems to be the most accurate one and it is particularly good at detecting negative sentiment. It would be very interesting to run Musk's tweets through it and compare the results with the sentimentr package and see if that noticeable downtrend is still present. And most importantly, sentiment analysis may not capture the full context of tweets or the intent behind Musk's messages as the computerized interpretation of sentiment may not fully represent the nuanced nature of human communication. One more important factor would be the wide range of potential external factors. External events, especially relating to Musk's other ventures, such as his companies Tesla or SpaceX, could have influenced his communication and could further explain the shift in sentiment. These factors were not explored in this study.

To prove my results are statistically significant, I had to find the p-value by running Person's chi-squared test. The chi-squared test is a statistical method used to determine if there is a significant association between two categorical variables. It compares the observed distribution of data to the distribution that would be expected if the variables were due to simply chance. I categorized the different sentiment scores into three categories, that are Negative, Neutral and Positive. I had to provide "breaks" which are values that delimit where those three categories start and end respectively. The polarity score in sentiment analysis has the value 0 as reflecting neutral sentiment, anything below 0 has negative sentiment and anything above 0 has positive sentiment. As can be seen in the console output below, a p-value of 7.17e-13 is extremely low, indicating strong evidence against the null hypothesis. It suggests that there is a strong and statistically significant association between the variables examined in this paper.

![Chi-squared Console Output](https://i.imgur.com/bOhrPFr.jpg)

5. **Conclusion**

In the ever-evolving landscape of social media and digital communication, the ubiquity and accessibility of these platforms have transformed the way individuals, including high-profile figures like Elon Musk, express their ideas. Musk's Twitter activity provided a fascinating case study as this research aimed to unravel the nuanced sentiment dynamics within his activity over the years.

My analysis identified a distinctive yet intriguing trend within Musk's tweets, a slow yet steady decline in sentiment. Reply tweets constitute a substantial portion of his activity, suggesting a willingness to engage in conversation through active participation in discussions, debates, and interactions. A closer look at the sentiment in his replies reveals the main reason for the consistent decline in overall sentiment, showing that his interactions have potentially become increasingly negative and confrontational.

Could this explain his highly risky acquisition of the platform itself? After all, his prioritizing of open dialogue, even at the expense of increasingly controversial and extreme content, inevitably hurt revenue, so profit-making did not seem to be the main reason behind it.

In summary, my research sheds light on the evolution of sentiment in Musk's Twitter presence. However, it remains a partial portrait of a much broader image, influenced by a multitude of external factors that warrant further investigation. The sentiment dynamics within Musk's tweets are complex and provide an opportunity for continued exploration of the realm of social media and online communication.

**References**

Counts and Maloney. ‘Twitter Now Worth Just One-Third of What Musk Paid for It’. Time, https://time.com/6283658/twitter-worth-third-musk-price-fidelity/

Drus, Zulfadzli, and Haliyana Khalid. ‘Sentiment Analysis in Social Media and Its Application: Systematic Literature Review’. Procedia Computer Science, vol. 161, Jan. 2019, pp. 707–14. ScienceDirect, https://doi.org/10.1016/j.procs.2019.11.174

Frenkel, Sheera, and Kate Conger. ‘Hate Speech’s Rise on Twitter Is Unprecedented, Researchers Find’. The New York Times, 2 Dec. 2022. NYTimes.com, https://www.nytimes.com/2022/12/02/technology/twitter-hate-speech.html

Gajare, Neal. ALL Elon Musk Tweets. [https://www.kaggle.com/datasets/neelgajare/all-elon- musk-tweets-2022-updated](https://www.kaggle.com/datasets/neelgajare/all-elon-musk-tweets-2022-updated)

Mäntylä, Mika V., et al. ‘The Evolution of Sentiment Analysis—A Review of Research Topics, Venues, and Top Cited Papers’. Computer Science Review, vol. 27, Feb. 2018, pp. 16–32. ScienceDirect, <https://doi.org/10.1016/j.cosrev.2017.10.002>

Myers, Steven Lee, et al. ‘The Consequences of Elon Musk’s Ownership of X’. The New York Times, 27 Oct. 2023. NYTimes.com, https://www.nytimes.com/interactive/2023/10/27/technology/twitter-x-elon-musk- anniversary.html

Napolitano, Elizabeth. ‘Musk Reveals Twitter Ad Revenue Is down 50% as Social Media Competition Mounts - CBS News’. CBS News, 17 July 2023, https://www.cbsnews.com/news/twitter-traffic-falls-under-elon-musk-threads-mastodon- bluesky-competition/

Rinker, Tyler. Sentimentr. 2015. 20 Sept. 2023. GitHub, https://github.com/trinker/sentimentr

Rodríguez-Ibánez, Margarita, et al. ‘A Review on Sentiment Analysis from Social Media Platforms’. Expert Systems with Applications, vol. 223, Aug. 2023, p. 119862. ScienceDirect, <https://doi.org/10.1016/j.eswa.2023.119862>

Sahu, Tirath Prasad, and Sanjeev Ahuja. ‘Sentiment Analysis of Movie Reviews: A Study on Feature Selection & Classification Algorithms’. 2016 International Conference on Microelectronics, Computing and Communications (MicroCom), 2016, pp. 1–6. IEEE Xplore, https://doi.org/10.1109/MicroCom.2016.7522583

Sudhir, Prajval, and Varun Deshakulkarni Suresh. ‘Comparative Study of Various Approaches, Applications and Classifiers for Sentiment Analysis’. Global Transitions Proceedings, vol. 2, no. 2, Nov. 2021, pp. 205–11. ScienceDirect, <https://doi.org/10.1016/j.gltp.2021.08.004>

**Appendix: R Code**
