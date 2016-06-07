package vn.luongvo.androidtest.capturing;

import android.support.test.rule.ActivityTestRule;
import android.support.test.runner.AndroidJUnit4;

import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;

import static android.support.test.espresso.Espresso.onView;
import static android.support.test.espresso.assertion.ViewAssertions.matches;
import static android.support.test.espresso.matcher.ViewMatchers.isDisplayed;
import static android.support.test.espresso.matcher.ViewMatchers.withText;

/**
 * Created by Luong Vo on 2/17/16.
 */
@RunWith(AndroidJUnit4.class)
public class NextActivityTest {

    @Rule
    public ActivityTestRule mActivityRule = new ActivityTestRule(NextActivity.class);

    @Test
    public void testUI() throws Exception {
        onView(withText("TextView")).check(matches(isDisplayed()));
        onView(withText("CheckBox")).check(matches(isDisplayed()));
    }
}









































































